//
//  ToolsPanel.swift
//  DoodleZP
//
//  Created by admin on 2/3/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

class ToolsPanel: UIView {
    
    // Possibly create buttonsStore to handle which buttons are available for different vares
    // vector, raster, selected line/lines, picking points etc
    var buttons = [ToolsPanelButton]()
    static var isShown = true
    var showHideToolsPanelButton: ShowHideToolsPanelButton?
    
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
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: self.superview!.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: self.superview!.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor),
//            self.heightAnchor.constraint(equalToConstant: 200)
            ])
        
        let doodleView = self.superview as! DoodleView
        showHideToolsPanelButton = ShowHideToolsPanelButton()
        showHideToolsPanelButton!.setup(with: self)
        doodleView.addSubview(showHideToolsPanelButton!)
        showHideToolsPanelButton!.addTarget(self, action: #selector(self.showHideBtnTap), for: .touchUpInside)
        buildPanelViewHierarchy()
    }
    
    func showHideBtnTap (_ sender: ShowHideToolsPanelButton) {
        if ToolsPanel.isShown {
            hideToolsPanel()
            sender.setImage(UIImage(named: "show_tools_panel"), for: .normal)
        } else {
            showToolsPanel()
            sender.setImage(UIImage(named: "hide_tools_panel"), for: .normal)
        }
    }
    
    func btnTap (_ sender: ToolsPanelButton) {
        
        let doodleView = self.superview as! DoodleView
        if doodleView.historyHandler == nil {
            doodleView.historyHandler = HistoryHandler(doodleView: doodleView)
        }
        doodleView.selectedStrokesIndexes.removeAll()
        switch sender.type {
        case .undo:
            doodleView.historyStep(backward: true)
        case .redo:
            doodleView.historyStep(backward: false)
        case .trash:
            
            let title = NSLocalizedString("Clear Canvas and History?", comment: "Clear Canvas and History Alert Title")
            let message = NSLocalizedString("Do you really want to clear all changes?", comment: "Clear Canvas and History Alert Message")
            let confirmString = NSLocalizedString("Confirm", comment: "Confirm button text")
            let cancelString = NSLocalizedString("Cancel", comment: "Cancel button text")
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let clearAll = UIAlertAction(title: confirmString, style: .destructive) { _ in
                doodleView.historyHandler!.clearCanvasAndHistory()
                doodleView.setNeedsDisplay()
            }
            let cancel = UIAlertAction(title: cancelString, style: .cancel, handler: nil)
            alert.addAction(cancel)
            alert.addAction(clearAll)
            
            self.parentViewController!.present(alert, animated: true, completion: nil)
            
        case .vector:
            NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationCenterKeys.vectorButtonSelected), object: self)
            NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationCenterKeys.rasterButtonDeselected), object: self)
        case .raster:
            NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationCenterKeys.rasterButtonSelected), object: self)
            NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationCenterKeys.vectorButtonDeselected), object: self)
        default:
            print("btnTap default")
        }
        
        doodleView.setNeedsDisplay()
    }
    
    func toggleToolsPanel() {
        ToolsPanel.isShown ? hideToolsPanel() : showToolsPanel()
    }
    
    private func showToolsPanel() {
        UIView.animate(withDuration: 0.3) {
            ToolsPanel.isShown = true
            let transition = CGAffineTransform(translationX: 0, y: 0)
            self.transform = transition
            self.showHideToolsPanelButton?.transform = transition
        }
        
    }
    
    private func hideToolsPanel() {
        UIView.animate(withDuration: 0.3) {
            ToolsPanel.isShown = false
            let height = self.bounds.size.height
            let transition = CGAffineTransform(translationX: 0, y: height)
            self.transform = transition
            self.showHideToolsPanelButton?.transform = transition
        }
    }
    
    func buildPanelViewHierarchy() {
    
        let windowFrame = UIApplication.shared.delegate!.window!!.frame
        let screenSideSize = orientation.isPortrait ? windowFrame.width : windowFrame.height
        let (buttonsInRow, buttonSize) = calculateButtonsParameters(screenSideSize: screenSideSize)
        print("\(buttonsInRow) size: \(buttonSize)")
        
        let store = ToolsPanelButtonStore.sharedInstance
        buttons = store.getAvailableOptions(state: .anyAction)
        
        for btn in buttons {
            btn.addTarget(self, action: #selector(self.btnTap), for: .touchUpInside)
//            buttons.append(btn)
        }
        
        let rows = splitButtonsArray(givenArray: buttons, buttonsInRow: buttonsInRow)
        var rowContainer: UIView
        
        print("rows: \(rows.count)")
        
        for (i, row) in rows.reversed().enumerated() {
        
            rowContainer = UIView()
            rowContainer.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(rowContainer)
            
            var topAnchorConstraint: NSLayoutConstraint
            
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
                
                
            for (index, item) in row.enumerated() {
                rowContainer.addSubview(item)
                
                var leadingConstraint: NSLayoutConstraint
                
                if index == 0 {
                    leadingConstraint = item.leadingAnchor.constraint(equalTo: rowContainer.leadingAnchor)
                } else {
                    leadingConstraint = item.leadingAnchor.constraint(equalTo: rowContainer.subviews[index-1].trailingAnchor)
                }
                
                NSLayoutConstraint.activate([
                    item.widthAnchor.constraint(equalToConstant: buttonSize),
                    item.heightAnchor.constraint(equalToConstant: buttonSize),
                    item.topAnchor.constraint(equalTo: rowContainer.topAnchor),
                    leadingConstraint
                    ])
                
            }
            
            print("buttons: \(buttons.count)")
            
            if i == rows.count-1 {
                NSLayoutConstraint.activate([
                    self.topAnchor.constraint(equalTo: rowContainer.topAnchor)
                    ])
            }
        }
        
        print("rows.count: \(self.subviews.count)")
        print("elements in first row: \(self.subviews.first!.subviews.count)")
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
        
        guard rowsNumber > 0 else {
            return result
        }
        for rowIndex in 1...rowsNumber {
            
            var newRow = [ToolsPanelButton]()
            let startPosition = (rowIndex-1) * buttonsInRow
            let endPosition = rowIndex * buttonsInRow
            
            for elementIndex in startPosition..<endPosition {
                
                guard elementIndex < givenArray.count else {
//                    let btn = ToolsPanelButton(random: true)
//                    newRow.append(btn)
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
    @available(*, deprecated)
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
