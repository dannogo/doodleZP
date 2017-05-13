//
//  PopupMenuBackgroundView.swift
//  DoodleZP
//
//  Created by Oleh Liskovych on 5/10/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

class PopupMenuBackgroundView: UIPopoverBackgroundView {
    
    override var arrowDirection: UIPopoverArrowDirection {
        get {
            return .down
        }
        set {
            
        }
    }

    override var arrowOffset: CGFloat {
        get {
            return 0
        }
        set {
            
        }
    }
    
    var arrowImageView: UIImageView
    
    override init(frame: CGRect) {
        self.arrowImageView = UIImageView(frame: CGRect.zero)
        super.init(frame: frame)
        self.arrowDirection = .down
//        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.normalState().cgColor
        self.arrowOffset = 0
        self.addSubview(self.arrowImageView)
    }
    
    override class var wantsDefaultContentAppearance: Bool {
        get {
            return false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override static func contentViewInsets() -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    override static func arrowBase() -> CGFloat {
        return 46.875
    }
    
    override static func arrowHeight() -> CGFloat {
        return 50
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let arrowSize = CGSize(width: type(of: self).arrowBase(), height: type(of: self).arrowHeight())
        self.arrowImageView.image = self.drawArrowImage(size: arrowSize)
        self.arrowImageView.frame = CGRect(x: self.bounds.width-arrowSize.width, y: self.bounds.height-arrowSize.height, width: arrowSize.width, height: arrowSize.height)
        
        print(#function)
    }
    
    private func drawArrowImage(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size , false, 0)
        let ctx = UIGraphicsGetCurrentContext()
        UIColor.clear.setFill()
        ctx!.fill(CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        
        let arrowPath = CGMutablePath()
        arrowPath.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
        arrowPath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        arrowPath.addLine(to: CGPoint(x: bounds.midX, y: bounds.maxY))
        arrowPath.closeSubpath()
        
        ctx!.setFillColor(UIColor.normalState().cgColor)
        ctx!.drawPath(using: .fill)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        print(#function)
        return image!
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
