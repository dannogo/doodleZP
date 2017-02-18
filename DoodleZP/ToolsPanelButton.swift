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
    
    private func getPositionConstraintsForButtonInRow(for button: ToolsPanelButton,
                                                      in row: UIView, with margin: CGFloat)
        -> (leading: NSLayoutConstraint, top: NSLayoutConstraint) {
            let leadingConstraint = button.leadingAnchor.constraint(equalTo: row.leadingAnchor, constant: margin)
            let topConstraint = button.topAnchor.constraint(equalTo: row.topAnchor, constant: margin)
            return (leadingConstraint, topConstraint)
    }
    
    private func setConstraints (for button: ToolsPanelButton,
                                 in row: UIView, sideLength: CGFloat, margin: CGFloat = 0) {
        let  widthConstraint = NSLayoutConstraint(item: button,
                attribute: NSLayoutAttribute.width,
                relatedBy: NSLayoutRelation.equal,
                toItem: nil,
                attribute: NSLayoutAttribute.notAnAttribute,
                multiplier: 1,
                constant: sideLength)
        let heightConstant = NSLayoutConstraint(item: button,
                attribute: NSLayoutAttribute.width,
                relatedBy: NSLayoutRelation.equal,
                toItem: nil,
                attribute: NSLayoutAttribute.notAnAttribute,
                multiplier: 1,
                constant: sideLength)
        
        button.addConstraint(widthConstraint)
        button.addConstraint(heightConstant)
        
        let positionConstraints = getPositionConstraintsForButtonInRow(for: button, in: row, with: margin)
        
        button.addConstraint(positionConstraints.leading)
        button.addConstraint(positionConstraints.top)
        
        positionConstraints.leading.isActive = true
        positionConstraints.top.isActive = true
        
    }

    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
