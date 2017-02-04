//
//  History.swift
//  DoodleZP
//
//  Created by admin on 2/4/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import Foundation

class History {
    
    var currentIndex: Int? = nil
    
    var history = [ChainLink]()
    
    func appendChainLink(_ chainLink: ChainLink) {
        remove(after: currentIndex)
        history.append(chainLink)
        currentIndex = currentIndex == nil ? 0 : currentIndex! + 1
    }
    
    func remove(after curIndex: Int?) {
        if let index = curIndex, index < (history.count - 1) {
            while index < (history.count - 1) {
                let _ = history.popLast()
            }
        }
    }
    
    func revert() -> ChainLink? {
        
        guard currentIndex != nil else {
            print("Unable to revert in: \(#file) method: \(#function)")
            return nil
        }
        currentIndex! += 1
    }
    
    func advance() {
        guard currentIndex != nil, history.count > 0,
            (history.count - 1) > currentIndex! else {
            print("Unable to advance in: \(#file) method: \(#function)")
            return
        }
        currentIndex! += 1
    }
    
}
