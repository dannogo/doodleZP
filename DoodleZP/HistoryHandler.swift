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
        print("Chainlink obtained in HistoryHandler")
        
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
                case .vectorChange:
                    for elementToDismiss in stateToDismiss {
                        if let elementToDismissUnwrapped = elementToDismiss {
                            for (index, element) in doodleView.finishedStrokes.enumerated() {
                                if elementToDismissUnwrapped.id == element.id {
                                    print("finishedLines: \(index) count: \(doodleView.finishedStrokes.count), element.id: \(element.id)")
                                    doodleView.finishedStrokes.remove(at: index)
                                }
                            }
                        }
                    }
                    
                    for elementToApply in stateToApply {
                        if let elementToApplyUnwrapped = elementToApply {
//                            print("insert finishedLines: \(index) count before: \(doodleView.finishedStrokes.count)")
                            doodleView.finishedStrokes.insert(elementToApplyUnwrapped, at: elementToApplyUnwrapped.layerIndex!)
//                            print("insert finishedLines: \(index) count after: \(doodleView.finishedStrokes.count)")
                        }
                    }
                    
                default:
                    break
                }
                
                
            }
        }
    }
    
    @available(*, deprecated)
    func handleHistoryStep(backward: Bool) {
        var stateToDismiss: [Element?]
        var stateToApply: [Element?]
        let chainLink = (backward) ? history.revert() : history.advance()
        print("Chainlink obtained in HandleHistory")
        
        if chainLink != nil {
            for (index, element) in doodleView.finishedStrokes.enumerated() {
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
                    case .vectorChange:
                        for elementToDismiss in stateToDismiss {
                            if let elementToDismissUnwrapped = elementToDismiss, elementToDismissUnwrapped.id == element.id {
                                print("index to remove: \(index), id: \(elementToDismissUnwrapped.id)")
                                doodleView.finishedStrokes.remove(at: index)
                            }
                        }
                        for elementToApply in stateToApply {
                            if let elementToApplyUnwrapped = elementToApply {
                                print("insert id: \(elementToApplyUnwrapped.id)")
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
    func stepping(backward: Bool){
        
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
