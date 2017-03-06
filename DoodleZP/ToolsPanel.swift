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
    
    override func didMoveToSuperview() {
        self.backgroundColor = UIColor.green
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: self.superview!.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: self.superview!.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor),
//            self.heightAnchor.constraint(equalToConstant: 200)
            ])
        
        buildPanelViewHierarchy()
    }
    
    
    func btnTap () {
        print("btn Tap")
    }
    
    func buildPanelViewHierarchy() {
    
        let windowFrame = UIApplication.shared.delegate!.window!!.frame
        let screenSideSize = orientation.isPortrait ? windowFrame.width : windowFrame.height
        let (buttonsInRow, buttonSize) = calculateButtonsParameters(screenSideSize: screenSideSize)
        print("\(buttonsInRow) size: \(buttonSize)")
        
        for _ in 0 ..< 24 {
            let btn = ToolsPanelButton(random: true)
            btn.setTitle(btn.hint, for: .normal)
            btn.addTarget(self, action: #selector(self.btnTap), for: .touchUpInside)
            btn.layer.borderWidth = 1.0
            btn.layer.borderColor = UIColor.blue.cgColor
            btn.layer.backgroundColor = UIColor.gray.cgColor
            buttons.append(btn)
        }
        
        let rows = splitButtonsArray(givenArray: buttons, buttonsInRow: buttonsInRow)
        
        self.backgroundColor = UIColor.green
        
        var rowContainer: UIView
        
        for (i, row) in rows.enumerated() {
        
            rowContainer = UIView()
            rowContainer.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(rowContainer)
            
            let colo: UIColor
            
            var topAnchorConstraint: NSLayoutConstraint
            switch i {
            case 0:
                colo = UIColor.cyan
            case 1:
                colo = UIColor.blue
            case 2:
                colo = UIColor.brown
            case 3:
                colo = UIColor.red
            default:
                colo = UIColor.gray
            }
            rowContainer.backgroundColor = colo
            
            if i == 0 {
                topAnchorConstraint = rowContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            } else {
                topAnchorConstraint = rowContainer.bottomAnchor.constraint(equalTo: self.subviews[i-1].topAnchor)
            }
            
            NSLayoutConstraint.activate([
                topAnchorConstraint,
                rowContainer.leadingAnchor.constraint(equalTo: self.superview!.leadingAnchor),
                rowContainer.trailingAnchor.constraint(equalTo: self.superview!.trailingAnchor),
                rowContainer.heightAnchor.constraint(equalToConstant: buttonSize)
            ])
                
                
            for item in row {
                rowContainer.addSubview(item)
                item.translatesAutoresizingMaskIntoConstraints = false
                item.setConstraints(sideLength: buttonSize)
                
            }
            
            if i == rows.count-1 {
                NSLayoutConstraint.activate([
                    self.topAnchor.constraint(equalTo: rowContainer.topAnchor)
                    ])
            }
        }
        
        print("rows.count: \(self.subviews.count)")
        print("elements in first row: \(self.subviews.first?.subviews.count)")
//        self.sizeToFit()
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    func getRandomColor() -> UIColor{
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
    func splitButtonsArray(givenArray: [ToolsPanelButton], buttonsInRow: Int) -> [[ToolsPanelButton]] {
        
        var result = [[ToolsPanelButton]]()
        let rowsNumber = Int(ceil(Double(givenArray.count) / Double(buttonsInRow)))
        
        print("rows: \(rowsNumber)")
        for rowIndex in 1...rowsNumber {
            
            var newRow = [ToolsPanelButton]()
            let startPosition = (rowIndex-1) * buttonsInRow
            let endPosition = rowIndex * buttonsInRow
            
            for elementIndex in startPosition..<endPosition {
                
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
    
    // Not in use
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


}
