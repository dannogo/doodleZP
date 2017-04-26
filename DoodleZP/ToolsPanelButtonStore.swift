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
            ToolsPanelButton(frame: CGRect.zero, type: .undo, state: .disabled),
            ToolsPanelButton(frame: CGRect.zero, type: .redo, state: .disabled)
        ]
    }
    
    func getAvailableOptions(state: State) -> [ToolsPanelButton] {
            allButtons.append(contentsOf: getUndoRedo())
            allButtons.append(ToolsPanelButton(frame: CGRect.zero, type: .vector, state: .selected))
            allButtons.append(ToolsPanelButton(frame: CGRect.zero, type: .raster, state: .normal))
            return allButtons
        }
    
}
