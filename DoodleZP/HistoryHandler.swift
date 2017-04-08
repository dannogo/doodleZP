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
    
    func vectorChange(stateToDismiss: [Element?], stateToApply: [Element?]) {
        
    }
    
    func handleHistoryStep(backward: Bool) {
        var stateToDismiss: [Element?]
        var stateToApply: [Element?]
        let chainLink = (backward) ? history.revert() : history.advance()
        
        if chainLink != nil {
            for (index, element) in doodleView.finishedStrokes.enumerated() {
                for transition in chainLink!.transitions {
                    if backward {
                        stateToDismiss = transition.toState
                        stateToApply = transition.fromState
                    } else {
                        stateToDismiss = transition.fromState
                        stateToApply = transition.toState
                    }
                    
                    switch chainLink!.changeType {
                    case .vectorChange:
                        for elementToDismiss in stateToDismiss {
                            if let elementToDismissUnwrapped = elementToDismiss, elementToDismissUnwrapped.id == element.id {
                                doodleView.finishedStrokes.remove(at: index)
                            }
                        }
                        for elementToApply in stateToApply {
                            if let elementToApplyUnwrapped = elementToApply {
                                doodleView.finishedStrokes.insert(elementToApplyUnwrapped, at: elementToApplyUnwrapped.layerIndex!)
                            }
                        }
                    default:
                        break
                    }
                    
                    
                }
            }
        }
    }
    
    @available(*, deprecated)
    func step(backward: Bool){
        
        if backward {
            if let chainLink = history.revert() {
                switch chainLink.changeType {
                case .vectorChange:
                    break
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
        } else {
            
        }
    }
}
