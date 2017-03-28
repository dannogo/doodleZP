//
//  ToolsPanelButtonStore.swift
//  DoodleZP
//
//  Created by admin on 2/3/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

class ToolsPanelButtonStore {
    
    var allButtons = [ToolsPanelButton]()
    
//    enum State {
//        DrawingStroke, PickingStrokes, EditingPoints
//    }
    
//    var modeOptions = 
    
//    @discardableResult func createDummyButton() -> ToolsPanelButton {
//        let newButton = ToolsPanelButton(random: true)
//        allButtons.append(newButton)
//        
//        return newButton
//    }
    
    
    enum State {
        case anyAction
    }
    
    private func getUndoRedo() -> [ToolsPanelButton]{
        return [
            ToolsPanelButton(frame: CGRect.zero, type: ToolsPanelButton.ActionType.undo),
            ToolsPanelButton(frame: CGRect.zero, type: ToolsPanelButton.ActionType.redo)
        ]
    }
    
    func getAvailableOptions(state: State) {
            allButtons.append(contentsOf: getUndoRedo())
            
        }
    
}
