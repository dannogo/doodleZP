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
    
    
    func step(backward: Bool) {
        var stateToDismiss: [Element?]
        var stateToApply: [Element?]
        let chainLink = (backward) ? history.revert() : history.advance()
        
        if chainLink != nil {
            for transition in chainLink!.transitions {
                stateToDismiss = [nil]
                stateToDismiss = [nil]
                if backward {
                    stateToDismiss = transition.toState
                    stateToApply = transition.fromState
                } else {
                    stateToDismiss = transition.fromState
                    stateToApply = transition.toState
                }
                
                switch chainLink!.changeType {
                case .vectorChange, .delete:
                    for elementToDismiss in stateToDismiss {
                        if let elementToDismissUnwrapped = elementToDismiss {
                            for (index, element) in doodleView.finishedStrokes.enumerated() {
                                if elementToDismissUnwrapped.id == element.id {
                                    doodleView.finishedStrokes.remove(at: index)
                                }
                            }
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
