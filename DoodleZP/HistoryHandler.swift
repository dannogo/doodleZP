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
    
    func clearCanvasAndHistory() {
        history.clearAll()
        doodleView.finishedStrokes.removeAll()
    }
    
    func step(backward: Bool) {
        var stateToDismiss: [Element?]
        var stateToApply: [Element?]
        let chainLink = (backward) ? history.revert() : history.advance()
        
        if chainLink != nil {
            for transition in chainLink!.transitions {
                stateToDismiss = [nil]
                stateToApply = [nil]
                if backward {
                    stateToDismiss = transition.toState
                    stateToApply = transition.fromState
                } else {
                    stateToDismiss = transition.fromState
                    stateToApply = transition.toState
                }
                
                switch chainLink!.changeType {
                case .vectorChange, .delete, .strokeMove:
                    for elementToDismiss in stateToDismiss {
                        if let elementToDismissUnwrapped = elementToDismiss {
                            for (index, element) in doodleView.finishedStrokes.enumerated() {
                                if elementToDismissUnwrapped.id == element.id {
//                                    let stroke = doodleView.finishedStrokes[index] as! Vector
//                                    print("remove address: \(Unmanaged.passRetained(stroke).toOpaque()) start: \(stroke.lines[0].start.point.x):\(stroke.lines[0].start.point.y), end: \(stroke.lines[0].end.point.x):\(stroke.lines[0].end.point.y)")
                                    doodleView.finishedStrokes.remove(at: index)
                                }
                            }
                        }
                    }
                    
                    for elementToApply in stateToApply {
                        if let elementToApplyUnwrapped = elementToApply {
                            let stroke = elementToApplyUnwrapped as! Vector
                            print("insert address: \(Unmanaged.passRetained(stroke).toOpaque()) start: \(stroke.lines[0].start.point.x):\(stroke.lines[0].start.point.y), end: \(stroke.lines[0].end.point.x):\(stroke.lines[0].end.point.y)")
                            let index: Int
                            if elementToApplyUnwrapped.layerIndex! > doodleView.finishedStrokes.count {
                                index = doodleView.finishedStrokes.count
                            } else {
                                index = elementToApplyUnwrapped.layerIndex!
                            }
                            
                            doodleView.finishedStrokes.insert(elementToApplyUnwrapped, at: index)
                        }
                    }
//                case .strokeMove:
//                    break
                default:
                    break
                }
                
                
            }
        }
    }
    
}
