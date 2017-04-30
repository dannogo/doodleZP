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
    
    var commonButtons = [ToolsPanelButton]()
    
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
    
    func getCommonOptions() -> [ToolsPanelButton] {
        
        commonButtons.append(contentsOf: getCommonButtons())
        allButtons.append(contentsOf: commonButtons)
        
        return allButtons
    }
    
    func getVectorOptions() -> [ToolsPanelButton] {
        return [
            ToolsPanelButton(frame: CGRect.zero, type: .editingPoints),
            ToolsPanelButton(frame: CGRect.zero, type: .fixedAngles),
            ToolsPanelButton(frame: CGRect.zero, type: .glue)
        ]
    }
    
    func getRasterOptions() -> [ToolsPanelButton] {
        
        return [
            ToolsPanelButton(frame: CGRect.zero, type: .eraser),
            ToolsPanelButton(frame: CGRect.zero, type: .eraser),
            ToolsPanelButton(frame: CGRect.zero, type: .eraser),
            ToolsPanelButton(frame: CGRect.zero, type: .eraser),
            ToolsPanelButton(frame: CGRect.zero, type: .eraser),
            ToolsPanelButton(frame: CGRect.zero, type: .eraser),
            ToolsPanelButton(frame: CGRect.zero, type: .eraser),
        ]
    }
    
    
    func updateAvailableOptions(action: ToolsPanelButton.ActionType) -> [ToolsPanelButton] {
        allButtons.removeAll()
        allButtons.append(contentsOf: commonButtons)
        
        switch action {
        case .vector:
            allButtons.append(contentsOf: getVectorOptions())
            print("update case \(action.rawValue)")
        case .raster:
            allButtons.append(contentsOf: getRasterOptions())
            print("update case \(action.rawValue)")
        default:
            break
        }
        
        return allButtons
    }
}
