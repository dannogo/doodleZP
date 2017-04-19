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
    
    func ableToAdvance() {
        var notificationKey = NotificationCenterKeys.historyForwardButtonStateEnabled
        if history.count == 0 || currentIndex == history.count || lastAction == .none {
            notificationKey = NotificationCenterKeys.historyForwardButtonStateDisabled
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: notificationKey), object: self)
    }
    
    func ableToRevert() {
        var notificationKey = NotificationCenterKeys.historyBackButtonStateEnabled
        if history.count == 0 || currentIndex == -1 {
            notificationKey = NotificationCenterKeys.historyBackButtonStateDisabled
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: notificationKey), object: self)
    }
    
    static let sharedInstance: History = History()
    var lastAction = LastAction.none
    
    enum LastAction {
        case none, revert, advance
    }
    
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
        lastAction = .none
        ableToAdvance()
        ableToRevert()
    }
    
    private func remove(after curIndex: Int?) {
        if let index = curIndex, index < (history.count - 1) {
            while index < (history.count - 1) {
                let _ = history.popLast()
            }
        }
    }
    
    func revert() -> ChainLink? {
        
        if lastAction == .advance {
            currentIndex! -= 1
        }
        
        guard var index = currentIndex, index >= 0 else {
            print("Unable to revert in: \(#file) method: \(#function)")
            return nil
        }
        currentIndex! -= 1
        // spike bug fixing
        if index == history.count {
            index -= 1
        }
        lastAction = .revert
        ableToAdvance()
        ableToRevert()
        return history[index]
    }
    
    func advance() -> ChainLink? {

        if lastAction == .revert {
            currentIndex! += 1
        }
        
        guard lastAction != .none else {
            print("No action to redo")
            return nil
        }
        
        guard let index = currentIndex, history.count > 0,
            history.count > currentIndex! else {
                print("Unable to advance in: \(#file) method: \(#function)")
                return nil
        }
        currentIndex! += 1
        lastAction = .advance
        ableToAdvance()
        ableToRevert()
        return history[index]
    }
    
}
