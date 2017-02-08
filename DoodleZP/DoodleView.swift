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
    
    var currentStrokes = [NSValue:Element]()
    var finishedStrokes = [Element]()
    var selectedStrokesIndexes: [Int] = [] {
        didSet {
            if selectedStrokesIndexes.isEmpty {
                let menu = UIMenuController.shared
                menu.setMenuVisible(false, animated: true)
            }
        }
    }
    var selectedPoint: Point? // not sure
    
    var temporaryColor: UIColor = UIColor.blue
    var temporaryThickness: CGFloat = 8
    
    var moveRecognizer: UIPanGestureRecognizer!
    
    required init?(coder aDecored: NSCoder) {
        super.init(coder: aDecored)
        
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
            selectedStrokesIndexes.append(index)
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
            finishedStrokes.remove(at: index)
            selectedStrokesIndexes.removeAll()
        }
        setNeedsDisplay()
    }
    
    func moveLine(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        guard !selectedStrokesIndexes.isEmpty else {
            return
        }
        
        if gestureRecognizer.state == .changed {
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
            
            for (_, element) in currentStrokes {
                if let vector = element as? Vector, let line = vector.lines.last {
                    
                    line.color.withAlphaComponent(0.7).setStroke()
                    strokeLine(line)
                }
            }
            
            for index in selectedStrokesIndexes {
                UIColor(netHex: 0x5DDFFF).setStroke()
                let selectedStroke = finishedStrokes[index]
                if let shape = selectedStroke as? Vector {
                    for line in shape.lines {
                        strokeLine(line)
                    }
                }
            }
        }
    }
    
    // MARK: - Touches events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let newShape = Vector()
            newShape.createLine(start: Point(location), end: Point(location), color: temporaryColor, thickness: temporaryThickness)
            
            let key = NSValue(nonretainedObject: touch)
            currentStrokes[key] = newShape
        }
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            if let shape = currentStrokes[key] as? Vector {
                shape.lines.last?.end.point = touch.location(in: self)
            }
        }
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            if let shape = currentStrokes[key] as? Vector {
                shape.lines.last?.end.point = touch.location(in: self)
                
                finishedStrokes.append(shape)
                currentStrokes.removeValue(forKey: key)
            }
        }
        setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentStrokes.removeAll()
        setNeedsDisplay()
    }
    
}













