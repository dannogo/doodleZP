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
    
    //    @available(*, deprecated)
    //    init(frame: CGRect, hint: String) {
    //        self.hint = hint
    //        super.init(frame: frame)
    //    }
    
    init(frame: CGRect, type: ActionType) {
        self.type = type
        super.init(frame: frame)
        setIconHint(type: type)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setIconHint(type: ActionType) {
        switch type {
        case .undo: hint = "Undo"
        case .redo: hint = "Redo"
        default: break
        }
//        icon = type == ActionType.placeholder ? nil : UIImage(contentsOfFile: type.rawValue)
        icon = type == ActionType.placeholder ? nil : UIImage(named: type.rawValue)
        self.setImage(icon, for: .normal)
        
        self.layer.borderWidth = 0.25
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.backgroundColor = UIColor.cyan.cgColor
    }
    
    static var dummyCount = 0
    
    //    convenience init(random: Bool) {
    //        if random {
    //            self.init(frame: CGRect.zero, hint: String(ToolsPanelButton.dummyCount))
    //            ToolsPanelButton.dummyCount += 1
    //        } else {
    //            self.init(frame: CGRect.zero, hint: "")
    //        }
    //        self.translatesAutoresizingMaskIntoConstraints = false
    //    }
    
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
    
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
