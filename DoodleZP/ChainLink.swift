//
//  ChainLink.swift
//  DoodleZP
//
//  Created by admin on 2/4/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import Foundation

class ChainLink {
    
    init(transitions : [Transition]) {
        self.transitions = transitions
    }
    
    var transitions: [Transition]
    
    enum ChangeType {
        case newVector, newRaster, deleteVector, DeleteRaster,
            erase, colorChange, thicknessChange, imageSet,
            vectorePointLocationChange
    }
    
    
    
}
