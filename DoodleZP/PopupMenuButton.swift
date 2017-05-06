//
//  PopupMenuButton.swift
//  DoodleZP
//
//  Created by Oleh Liskovych on 5/6/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

class PopupMenuButton: UIButton {

    private let type: ToolsPanelButton.ActionType
    private let color: UIColor
    private let thickness: CGFloat
//    private let lineWidth: CGFloat = 5.0
    private let radius: CGFloat = 5.0
    
    
    private var buttonCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    init(type: ToolsPanelButton.ActionType, color: UIColor = UIColor.darkGray, thickness: CGFloat = 1.0) {
        self.type = type
        self.color = color
        self.thickness = thickness
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func pathForCircleCenteredAtPoint(midPoint: CGPoint, withRadius radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath(
            arcCenter: midPoint,
            radius: radius,
            startAngle: 0.0,
            endAngle: CGFloat(2*Double.pi),
            clockwise: false
        )
        path.lineWidth = thickness
        return path
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        color.set()
        switch type {
        case .palette:
            pathForCircleCenteredAtPoint(midPoint: buttonCenter, withRadius: 5.0).stroke()
        case .thickness:
            break
        default:
            break
        }
        
    }

}
