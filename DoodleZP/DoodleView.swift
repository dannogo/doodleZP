//
//  DoodleView.swift
//  DoodleZP
//
//  Created by admin on 2/3/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

@IBDesignable
class DoodleView: UIView, UIGestureRecognizerDelegate {
    
    let history = History.sharedInstance
    var historyHandler: HistoryHandler?
    var preventNewLine = false
    var transitions = [Transition]()
    // for raster only
    var lastRasterPoint = CGPoint.zero
    var swiped = false
    let tempImageView = UIImageView()
    let mainImageView = UIImageView()
    
    var currentStrokes = [NSValue:Element]()
    var finishedStrokes = [Element]()
    var selectedStrokesIndexes: [Int] = [] {
        didSet {
            if selectedStrokesIndexes.isEmpty {
                let menu = UIMenuController.shared
                menu.setMenuVisible(false, animated: true)
                preventNewLine = false
                resignFirstResponder()
            } else {
                preventNewLine = true
            }
        }
    }
    var selectedPoint: Point? // not sure
    
    var currentColor: UIColor = UIColor.blue
    var currentThickness: CGFloat = 8
    
    var moveRecognizer: UIPanGestureRecognizer!
    
    init() {
        super.init(frame: CGRect.zero)
        applyGestureRecognizers()
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecored: NSCoder) {
        super.init(coder: aDecored)
        applyGestureRecognizers()
    }
    
    func historyStep(backward: Bool) {
        historyHandler?.step(backward: backward)
    }
    
    func applyGestureRecognizers() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(DoodleView.tap(_:)))
        tapRecognizer.delaysTouchesBegan = true
        addGestureRecognizer(tapRecognizer)
        
        moveRecognizer = UIPanGestureRecognizer(target: self, action: #selector(DoodleView.moveLine(_:)))
        moveRecognizer.delegate = self
        moveRecognizer.cancelsTouchesInView = false
        addGestureRecognizer(moveRecognizer)
    }
    
    
    // MARK: - Delegate Methods
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // MARK: - GestureRecognizer actions
    func tap(_ gestureRecognizer: UIGestureRecognizer) {
        let point = gestureRecognizer.location(in: self)
        if let index = indexOfShape(at: point) {
            if selectedStrokesIndexes.contains(index) {
                if let indexOfIndex = selectedStrokesIndexes.index(of: index) {
                    selectedStrokesIndexes.remove(at: indexOfIndex)
                }
            } else {
                selectedStrokesIndexes.append(index)
            }
        } else {
            selectedStrokesIndexes.removeAll()
        }
        
        let menu = UIMenuController.shared
        
        if !selectedStrokesIndexes.isEmpty {
            becomeFirstResponder()
            let deleteItem = UIMenuItem(title: "Delete", action: #selector(DoodleView.deleteStrokes(_:)))
            menu.menuItems = [deleteItem]
            let targetRect = CGRect(x: point.x, y: point.y, width: 2, height: 2)
            menu.setTargetRect(targetRect, in: self)
            menu.setMenuVisible(true, animated: true)
            
        } else {
            menu.setMenuVisible(false, animated: true)
        }
        
        setNeedsDisplay()
    }
    
    func deleteStrokes(_ sender: UIMenuController) {
        
        for index in selectedStrokesIndexes.sorted(by: >) {
            let removedStroke = finishedStrokes.remove(at: index)
            let transition = Transition(fromState: [removedStroke], toState: [nil])
            transitions.append(transition)
            selectedStrokesIndexes.removeAll()
        }
        let chainLink = ChainLink(changeType: .delete, transitions: transitions)
        history.append(chainLink: chainLink)
        transitions.removeAll()
        setNeedsDisplay()
    }
    
    func moveLine(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        guard !selectedStrokesIndexes.isEmpty else {
            return
        }
        
        switch gestureRecognizer.state {
        case .began:
            for index in selectedStrokesIndexes.sorted(by: >) {
                let originalStroke = finishedStrokes[index]
                let strokeCopy: Element
                if ((originalStroke as? Vector) != nil) {
                    strokeCopy = (originalStroke as! Vector).copy() as! Element
                } else {
                    strokeCopy = finishedStrokes[index] // Just for now. Replace with copies of other non Vector Elements
                }
                let transition = Transition(fromState: [originalStroke], toState: [nil])
                finishedStrokes[index] = strokeCopy
                transitions.append(transition)
            }
        case .changed:
            let translation = gestureRecognizer.translation(in: self)
            for index in selectedStrokesIndexes {
                if let shape = finishedStrokes[index] as? Vector {
                    for line in shape.lines {
                        line.start.point.x += translation.x
                        line.start.point.y += translation.y
                        line.end.point.x += translation.x
                        line.end.point.y += translation.y
                    }
                }
                
                gestureRecognizer.setTranslation(CGPoint.zero, in: self)
                
                setNeedsDisplay()
            }
        case .ended:
            var transitionIndex = 0
            for index in selectedStrokesIndexes.sorted(by: >) {
                let movedStroke = finishedStrokes[index]
                transitions[transitionIndex].toState = [movedStroke]
                transitionIndex += 1
            }
            
            let chainLink  = ChainLink(changeType: .strokeMove, transitions: transitions)
            history.append(chainLink: chainLink)
            transitions.removeAll()
            
        default:
            break
        }
        
    }
    
    // MARK: - Overriden Methods
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - Supporting Methods
    func indexOfShape(at point: CGPoint) -> Int? {
        for (index, element) in finishedStrokes.enumerated() {
            // TODO: handle for raster
            if let shape = element as? Vector {
                for line in shape.lines {
                    // TODO: Check if its point editing mode
                    let start = line.start.point
                    let end = line.end.point
                    
                    for t in stride(from: CGFloat(0), to: 1.0, by: 0.05) {
                        let x = start.x + ((end.x - start.x) * t)
                        let y = start.y + ((end.y - start.y) * t)
                        
                        if hypot(x - point.x, y - point.y) < 12.0 {
                            return index
                        }
                    }
                }
            }
        }
        return nil
    }
    
    // MARK: - Drawing
    func strokeLine(_ line: Line) {
        let path = UIBezierPath()
        path.lineWidth = line.thickness
        path.lineCapStyle = .round
        
        path.move(to: line.start.point)
        path.addLine(to: line.end.point)
        path.stroke()
    }
    
    
    override func draw(_ rect: CGRect) {
        for stroke in finishedStrokes {
            if let shape = stroke as? Vector {
                for line in shape.lines {
                    line.color.setStroke()
                    strokeLine(line)
                }
            }
        }
        
        for (_, element) in currentStrokes {
            if let vector = element as? Vector, let line = vector.lines.last {
                line.color.withAlphaComponent(0.5).setStroke()
                strokeLine(line)
            }
            
        }
        
        for index in selectedStrokesIndexes {
            UIColor.selectedStroke().setStroke()
            let selectedStroke = finishedStrokes[index]
            if let shape = selectedStroke as? Vector {
                for line in shape.lines {
                    strokeLine(line)
                }
            }
        }
        
    }
    
    private func touchesBeganVector(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard !preventNewLine else {
            return
        }
        
        for touch in touches {
            let location = touch.location(in: self)
            let newShape = Vector(id: UUID())
            newShape.createLine(id: UUID(), start: Point(location, id: UUID()), end: Point(location, id: UUID()), color: currentColor, thickness: currentThickness)
            
            let key = NSValue(nonretainedObject: touch)
            currentStrokes[key] = newShape
        }
        setNeedsDisplay()
    }
    
    private func touchesBeganRaster(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            lastRasterPoint = touch.location(in: self)
        }
    }
    
    
    // MARK: - Touches events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if DrawingStates.shared.isVectorMode {
            touchesBeganVector(touches, with: event)
        } else {
            touchesBeganRaster(touches, with: event)
        }
    }
    
    private func touchesMovedVector(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            if let shape = currentStrokes[key] as? Vector {
                shape.lines.last?.end.point = touch.location(in: self)
            }
        }
        setNeedsDisplay()
    }
    
    private func touchesMovedRaster(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            drawRasterLine(from: lastRasterPoint, to: currentPoint)
            
            lastRasterPoint = currentPoint
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if DrawingStates.shared.isVectorMode {
            touchesMovedVector(touches, with: event)
        } else {
            touchesMovedRaster(touches, with: event)
        }
        
    }
    
    private func drawRasterLine(from origin: CGPoint, to destination: CGPoint) {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        
        context?.move(to: origin)
        context?.addLine(to: destination)
        
        context?.setLineCap(.round)
        context?.setLineWidth(currentThickness)
        context?.setStrokeColor(currentColor.cgColor)
        context?.setBlendMode(.normal)
        
        context?.strokePath()
        
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        //        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
    }
    
    private func touchesEndedVector(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            if let shape = currentStrokes[key] as? Vector {
                shape.lines.last?.end.point = touch.location(in: self)
                shape.layerIndex = finishedStrokes.count
                print("new line id: \(shape.id)")
                
                finishedStrokes.append(shape)
                // TODO: Add chainlink here
                let transition = Transition(fromState: [nil], toState: [shape])
                let chainLink = ChainLink(changeType: .vectorChange, transitions: [transition])
                history.append(chainLink: chainLink)
                currentStrokes.removeValue(forKey: key)
            }
        }
        setNeedsDisplay()
    }
    
    private func touchesEndedRaster(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawRasterLine(from: lastRasterPoint, to: lastRasterPoint)
        }
        
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0.0)
        mainImageView.image?.draw(in:
            CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            , blendMode: .normal
            , alpha: 1.0)
        tempImageView.image?.draw(in:
            CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            , blendMode: .normal
            , alpha: 1.0) // veriable opacity instead of 1.0
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        tempImageView.image = nil
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if DrawingStates.shared.isVectorMode {
            touchesEndedVector(touches, with: event)
        } else {
            touchesEndedRaster(touches, with: event)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentStrokes.removeAll()
        setNeedsDisplay()
    }
    
}













