//
//  ToolsPanel.swift
//  DoodleZP
//
//  Created by admin on 2/3/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

class ToolsPanel: UIView {

    var graphicMode: ModeHandler.GraphicMode? {
        didSet {
            // Redraw panel with other available options
        }
    }
    
    // Possibly create buttonsStore to handle which buttons are available for different modes
    // vector, raster, selected line/lines, picking points etc
    let buttons = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
    
    // Possibly make separated UIView subclass for ToolsPanel buttons
    struct ToolButton {
        let hint: String
        let icon: UIImage?
        let action: () -> ()?
        let state: ToolButtonState = .normal
        
        enum ToolButtonState {
            case normal, pressed, inactive
        }
    }
    
    var orientation: UIInterfaceOrientation = .portrait {
        didSet {
            // Redraw panel in new place
            
            
            buildPanelViewHierarchy()
            
        }
    }
    
    func buildPanelViewHierarchy() {
        
        let windowFrame = UIApplication.shared.delegate!.window!!.frame
        let screenSideSize = orientation.isPortrait ? windowFrame.width : windowFrame.height
        let (buttonsInRow, buttonSize) = calculateButtonsParameters(screenSideSize: screenSideSize)
        print("\(buttonsInRow) size: \(buttonSize)")
    }
    
    // Move calling this method somewhere else in order to execure it only once
    func calculateButtonsParameters(screenSideSize: CGFloat) -> (buttonsInRow: Int, buttonSize: CGFloat) {
        let buttonsInRow = (screenSideSize / 28).rounded()
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
