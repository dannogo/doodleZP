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
    
//    var modeOptions = 
    
    @discardableResult func createDummyButton() -> ToolsPanelButton {
        let newButton = ToolsPanelButton(random: true)
        allButtons.append(newButton)
        
        return newButton
    }
    
}
