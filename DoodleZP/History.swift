//
//  History.swift
//  DoodleZP
//
//  Created by admin on 2/4/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import Foundation

class History {
    
    private init() {}
    
    static let sharedInstance: History = History()
    
    private var currentIndex: Int? = nil
    private var history = [ChainLink]()
    private var historyMaxSize = 50
    
    @discardableResult private func handleOverflow() -> Int { // Returns number of removed chainlinks
        
        
        return 0
    }
    
    func append(chainLink: ChainLink) {
        remove(after: currentIndex)
        history.append(chainLink)
        currentIndex = currentIndex == nil ? 0 : currentIndex! + 1
    }
    
    private func remove(after curIndex: Int?) {
        if let index = curIndex, index < (history.count - 1) {
            while index < (history.count - 1) {
                let _ = history.popLast()
            }
        }
    }
    
    func revert() -> ChainLink? {
        
        guard let index = currentIndex, index >= 0 else {
            print("Unable to revert in: \(#file) method: \(#function)")
            return nil
        }
        currentIndex! -= 1
        return history[index]
    }
    
    func advance() -> ChainLink? {
        guard let index = currentIndex, history.count > 0,
            (history.count - 1) > currentIndex! else {
            print("Unable to advance in: \(#file) method: \(#function)")
            return nil
        }
        currentIndex! += 1
        return history[index]
    }
    
}
