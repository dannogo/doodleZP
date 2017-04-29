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
    
    private func getCommonButtons() -> [ToolsPanelButton]{
        return [
            ToolsPanelButton(frame: CGRect.zero, type: .undo, state: .disabled),
            ToolsPanelButton(frame: CGRect.zero, type: .redo, state: .disabled),
            ToolsPanelButton(frame: CGRect.zero, type: .trash, state: .disabled),
            ToolsPanelButton(frame: CGRect.zero, type: .vector, state: .selected),
            ToolsPanelButton(frame: CGRect.zero, type: .raster, state: .normal)
        ]
    }
    
    func getAvailableOptions(state: State) -> [ToolsPanelButton] {
            allButtons.append(contentsOf: getCommonButtons())
        
            return allButtons
        }
    
    func getVectorOptions() -> [ToolsPanelButton] {
        
        return [ToolsPanelButton]()
    }
    
    func getRasterOptions() -> [ToolsPanelButton] {
        
        return [ToolsPanelButton]()
    }
    
    func updateAvailableOptions() -> [ToolsPanelButton] {
        
        
        return [ToolsPanelButton]()
    }
}
