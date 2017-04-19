//
//  ToolsPanelButton.swift
//  DoodleZP
//
//  Created by admin on 2/3/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

class ToolsPanelButton: UIButton {
    
    var hint: String? = nil
    let type: ActionType
    var icon: UIImage? = nil
    let action: (() -> ())? = nil
    
    enum ActionType: String {
        case placeholder, undo, redo
    }
    
    
    init(frame: CGRect, type: ActionType, state: UIControlState = .normal) {
        self.type = type
        super.init(frame: frame)
        switch state {
        case UIControlState.disabled:
            self.isEnabled = false
        case UIControlState.selected:
            self.isSelected = true
        default:
            break
        }
        setAppearance(type: type)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setAppearance(type: ActionType) {
        var enableKey: String?
        var disableKey: String?
        
        switch type {
        case .undo:
            hint = "Undo"
            enableKey = NotificationCenterKeys.historyBackButtonStateEnabled
            disableKey = NotificationCenterKeys.historyBackButtonStateDisabled
        case .redo:
            hint = "Redo"
            enableKey = NotificationCenterKeys.historyForwardButtonStateEnabled
            disableKey = NotificationCenterKeys.historyForwardButtonStateDisabled
        default: break
        }
        
        if let enable = enableKey, let disable = disableKey {
            NotificationCenter.default.addObserver(self, selector: #selector(ToolsPanelButton.setEnabledState), name: NSNotification.Name(rawValue: enable), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(ToolsPanelButton.setDisabledState), name: NSNotification.Name(rawValue: disable), object: nil)
        }
        
        icon = type == ActionType.placeholder ? nil : UIImage(named: type.rawValue)
        self.setImage(icon, for: .normal)
        
        self.layer.borderWidth = 0.25
        self.layer.borderColor = UIColor.gray.cgColor
        if self.isSelected {
            self.layer.backgroundColor = UIColor.selectedState().cgColor
        } else {
            self.layer.backgroundColor = UIColor.normalState().cgColor
        }
        
    }
    
    static var dummyCount = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraints Methods
    private func getPositionConstraintsForButtonInRow(with margin: CGFloat)
        -> (leading: NSLayoutConstraint, top: NSLayoutConstraint) {
            let anchorToAttachTo: NSLayoutXAxisAnchor
            if self.superview!.subviews.count == 0{
                anchorToAttachTo = self.superview!.leadingAnchor
            } else {
                anchorToAttachTo = self.superview!.subviews[self.superview!.subviews.count - 1].trailingAnchor
            }
            
            let leadingConstraint = self.leadingAnchor.constraint(equalTo: anchorToAttachTo, constant: margin)
            let topConstraint = self.topAnchor.constraint(equalTo: self.superview!.topAnchor, constant: margin)
            return (leadingConstraint, topConstraint)
    }
    
    internal func setConstraints (sideLength: CGFloat, margin: CGFloat = 0) {
        let  widthConstraint = NSLayoutConstraint(item: self,
                                                  attribute: NSLayoutAttribute.width,
                                                  relatedBy: NSLayoutRelation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutAttribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: sideLength)
        let heightConstant = NSLayoutConstraint(item: self,
                                                attribute: NSLayoutAttribute.height,
                                                relatedBy: NSLayoutRelation.equal,
                                                toItem: nil,
                                                attribute: NSLayoutAttribute.notAnAttribute,
                                                multiplier: 1,
                                                constant: sideLength)
        
        self.addConstraint(widthConstraint)
        self.addConstraint(heightConstant)
        
        let positionConstraints = getPositionConstraintsForButtonInRow(with: margin)
        
        self.addConstraint(positionConstraints.leading)
        positionConstraints.leading.isActive = true
        
        print("button number: \(self.superview!.subviews.count)")
        self.translatesAutoresizingMaskIntoConstraints = false // delete later
        
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: self.superview!.topAnchor)
            ])
        
    }
    
    func setEnabledState() {
        self.isEnabled = true
    }
    
    func setDisabledState() {
        self.isEnabled = false
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
