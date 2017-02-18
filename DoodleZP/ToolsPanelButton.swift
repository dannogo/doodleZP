//
//  ToolsPanelButton.swift
//  DoodleZP
//
//  Created by admin on 2/3/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

class ToolsPanelButton: UIButton {
    
    let hint: String
    let icon: UIImage? = nil
    let action: (() -> ())? = nil
    
    init(frame: CGRect, hint: String) {
        self.hint = hint
        super.init(frame: frame)
    }
    
    static var dummyCount = 0
    
    convenience init(random: Bool) {
        if random {
            ToolsPanelButton.dummyCount += 1
            self.init(frame: CGRect.zero, hint: String(ToolsPanelButton.dummyCount))
        } else {
            self.init(frame: CGRect.zero, hint: "")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Constraints Methods
    private func getPositionConstraintsForButtonInRow(with margin: CGFloat)
        -> (leading: NSLayoutConstraint, top: NSLayoutConstraint) {
            let viewToAttachTo: UIView
            if self.superview!.subviews.count == 0{
                viewToAttachTo = self.superview!
            } else {
                viewToAttachTo = self.superview!.subviews[self.superview!.subviews.count - 1]
            }
            
            let leadingConstraint = self.leadingAnchor.constraint(equalTo: viewToAttachTo.leadingAnchor, constant: margin)
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
                attribute: NSLayoutAttribute.width,
                relatedBy: NSLayoutRelation.equal,
                toItem: nil,
                attribute: NSLayoutAttribute.notAnAttribute,
                multiplier: 1,
                constant: sideLength)
        
        self.addConstraint(widthConstraint)
        self.addConstraint(heightConstant)
        
        widthConstraint.isActive = true  // not sure
        heightConstant.isActive = true  // not sure
        
        let positionConstraints = getPositionConstraintsForButtonInRow(with: margin)
//
        self.addConstraint(positionConstraints.leading)
//        self.addConstraint(positionConstraints.top)
//
        positionConstraints.leading.isActive = true
//        positionConstraints.top.isActive = true
        
    }

    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
