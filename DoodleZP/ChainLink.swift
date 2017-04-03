//
//  ChainLink.swift
//  DoodleZP
//
//  Created by admin on 2/4/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import Foundation

class ChainLink {
    
    init(changeType: ChangeType, transitions : [Transition]) {
        self.changeType = changeType
        self.transitions = transitions
    }
    
    let transitions: [Transition]
    let changeType: ChangeType
    
    
    enum ChangeType {
        case vectorNew, vectorMerge, vectorSeparation, vectorDelete, vectorPointLocationChange,
        newRaster, DeleteRaster, erase,
        colorChange, thicknessChange, imageSet
    }
    
    
    
}
