//
//  PopupMenuBackgroundView.swift
//  DoodleZP
//
//  Created by Oleh Liskovych on 5/10/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

class PopupMenuBackgroundView: UIPopoverBackgroundView {
    
    static var width: CGFloat = 46.875
    
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
//        return type(of: self).width
        return PopupMenuBackgroundView.width
    }
    
    override static func arrowHeight() -> CGFloat {
        return PopupMenuBackgroundView.width / 2.4
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let arrowSize = CGSize(width: type(of: self).arrowBase(), height: type(of: self).arrowHeight())
        self.arrowImageView.image = drawArrow(size: arrowSize)
        self.arrowImageView.frame = CGRect(x: self.bounds.width-arrowSize.width, y: self.bounds.height-arrowSize.height, width: arrowSize.width, height: arrowSize.height)
    }
    
    private func drawArrow(size: CGSize) -> UIImage {
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 0))
        bezierPath.addLine(to: CGPoint(x: size.width, y: 0))
        bezierPath.addLine(to: CGPoint(x: size.width/2, y: size.height))
        bezierPath.addLine(to: CGPoint(x: 0, y: 0))
        bezierPath.lineWidth = 0.25
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        bezierPath.stroke()
        UIColor.normalState().setFill()
        bezierPath.fill()
        context!.setFillColor(UIColor.normalState().cgColor)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
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
