//
//  ToolsPanelButtonStore.swift
//  DoodleZP
//
//  Created by admin on 2/3/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

class ToolsPanelButtonStore {
    
    private init() {}
    
    static let sharedInstance: ToolsPanelButtonStore = ToolsPanelButtonStore()
    
    var allButtons = [ToolsPanelButton]()
    
//    enum State {
//        DrawingStroke, PickingStrokes, EditingPoints
//    }
    
    enum State {
        case anyAction
    }
    
    private func getUndoRedo() -> [ToolsPanelButton]{
        return [
            ToolsPanelButton(frame: CGRect.zero, type: .undo),
            ToolsPanelButton(frame: CGRect.zero, type: .redo)
        ]
    }
    
    func getAvailableOptions(state: State) -> [ToolsPanelButton] {
            allButtons.append(contentsOf: getUndoRedo())
        
            return allButtons
        }
    
}
