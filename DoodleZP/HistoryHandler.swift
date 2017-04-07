//
//  HistoryHandler.swift
//  DoodleZP
//
//  Created by admin on 4/2/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

class HistoryHandler {

    weak var doodleView: DoodleView!
    let history = History.sharedInstance
    
    init(doodleView: DoodleView) {
        self.doodleView = doodleView
    }
    
    func vectorNewRevert() {
        
    }
    
    func step(backward: Bool){
        if backward {
            if let chainLink = history.revert() {
                switch chainLink.changeType {
                case .vectorNew:
                    for (index, element) in doodleView.finishedStrokes.enumerated() {
                        if element is Vector {
                            for transition in chainLink.transitions {
                                for toStateElement in transition.toState {
                                    if toStateElement!.id == element.id {
                                        doodleView.finishedStrokes.remove(at: index)
                                    }
                                }
                            }
                        }
                    }
                case .vectorMerge:
                    break
                case .vectorSeparation:
                    break
                case .vectorDelete:
                    break
                case .vectorPointLocationChange:
                    break
                default:
                    break
                }

            }
        }
    }
}
