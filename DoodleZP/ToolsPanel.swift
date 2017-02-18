//
//  ToolsPanel.swift
//  DoodleZP
//
//  Created by admin on 2/3/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

class ToolsPanel: UIView {
    
    // Possibly create buttonsStore to handle which buttons are available for different modes
    // vector, raster, selected line/lines, picking points etc
    var buttons = [ToolsPanelButton]()
    let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 2
        stack.translatesAutoresizingMaskIntoConstraints = false
        print("stack.isUserInteractionEnabled: \(stack.isUserInteractionEnabled)")
        return stack
    }()
    
    
    var orientation: UIInterfaceOrientation = .portrait {
        didSet {
            // Redraw panel in new place
            
//            buildPanelViewHierarchy()
            
        }
    }
    
    // MARK: - Overriden Methods
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        
//        resizeToFitSubviews()
//        self.layer.backgroundColor = UIColor.yellow.cgColor
        
    }
    
    override func didMoveToSuperview() {
//        self.frame.origin.y = self.superview!.frame.height - self.frame.height
        buildPanelViewHierarchy()
    }
    
    // Try to make it with constraints
    private func resizeToFitSubviews() {
        var width: CGFloat = 0
        var height: CGFloat = 0
        var originX: CGFloat = 0
        var originY: CGFloat = 0
        
        for subview in self.subviews {
            originX = min(subview.frame.origin.x, originX)
            originY = min(subview.frame.origin.y, originY)
            let subWidth = subview.frame.origin.x + subview.frame.size.width
            let subHeight = subview.frame.origin.y + subview.frame.size.height
            width = max(subWidth, width)
            height = max(subHeight, height)
            
        }
        
        self.frame = CGRect(x: originX, y: originY, width: width, height: height)
        
    }
    
    func btnTap () {
        print("btn Tap")
    }
    
    func buildPanelViewHierarchy() {
        
        
        self.addSubview(mainStack)
    
        let windowFrame = UIApplication.shared.delegate!.window!!.frame
        let screenSideSize = orientation.isPortrait ? windowFrame.width : windowFrame.height
        let (buttonsInRow, buttonSize) = calculateButtonsParameters(screenSideSize: screenSideSize)
        print("\(buttonsInRow) size: \(buttonSize)")
        
        for _ in 0 ..< 8 {
            let btn = ToolsPanelButton(random: true)
            btn.setTitle(btn.hint, for: .normal)
//            let size = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
            btn.bounds.size.height = buttonSize
            btn.bounds.size.width = buttonSize
//            btn.frame = size
            btn.addTarget(self, action: #selector(self.btnTap), for: .touchUpInside)
            btn.layer.borderWidth = 1.0
            btn.layer.borderColor = UIColor.blue.cgColor
            btn.layer.backgroundColor = UIColor.gray.cgColor
            buttons.append(btn)
        }
        
        let rows = splitButtonsArray(givenArray: buttons, buttonsInRow: buttonsInRow)
        
        
        for row in rows.reversed() {
            
            let rowContainer = UIView(frame: CGRect(x: 0, y: 0, width: screenSideSize, height: buttonSize * 3))
            
            
            rowContainer.bounds.size.width = screenSideSize
            rowContainer.bounds.size.height = buttonSize * 3
            rowContainer.backgroundColor = UIColor.red
            
            for item in row {
                rowContainer.addSubview(item)
                item.setConstraints(sideLength: buttonSize)
                
            }
            
            self.mainStack.insertArrangedSubview(rowContainer, at: 0)
            
        }
        
        print("rows.count: \(mainStack.arrangedSubviews.count)")
        print("elements in first row: \(mainStack.arrangedSubviews.first?.subviews.count)")
//        self.sizeToFit()
        setNeedsLayout()
//        layoutIfNeeded()
    }
    
    func splitButtonsArray(givenArray: [ToolsPanelButton], buttonsInRow: Int) -> [[ToolsPanelButton]] {
        
        var result = [[ToolsPanelButton]]()
        let rowsNumber = Int(ceil(Double(givenArray.count) / Double(buttonsInRow)))
        
        print("rows: \(rowsNumber)")
        for rowIndex in 1...rowsNumber {
            
            var newRow = [ToolsPanelButton]()
            let startPosition = (rowIndex-1) * buttonsInRow
            let endPosition = rowIndex * buttonsInRow
//            print("row: \(rowIndex)")
            
            for elementIndex in startPosition..<endPosition {
//                print("elementIndex: \(elementIndex)")
                
                guard elementIndex < givenArray.count else {
                    let btn = ToolsPanelButton(random: true)
                    btn.layer.borderWidth = 1.0
                    btn.layer.borderColor = UIColor.gray.cgColor
                    newRow.append(btn)
                    continue
                }
                
                newRow.append(givenArray[elementIndex])
            }
            result.append(newRow)
        }
        
        return result
    }
    
    // Move calling this method somewhere else in order to execure it only once
    func calculateButtonsParameters(screenSideSize: CGFloat) -> (buttonsInRow: Int, buttonSize: CGFloat) {
        let buttonsInRow = (screenSideSize / 50).rounded()
        let buttonSize = screenSideSize / buttonsInRow
        return (Int(buttonsInRow), buttonSize)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
