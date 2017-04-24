//
//  ShowHideToolsPanelButton.swift
//  DoodleZP
//
//  Created by Oleh Liskovych on 4/24/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

class ShowHideToolsPanelButton: UIButton {
    
    @available(*, deprecated)
    private func pathForBorder() -> UIBezierPath {

        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        bezierPath.addLine(to: CGPoint(x: bounds.width/7, y: bounds.minY))
        bezierPath.addLine(to: CGPoint(x: bounds.width - bounds.width/7, y: bounds.minY))
        bezierPath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        UIColor.normalState().setFill()
        bezierPath.fill()
        bezierPath.lineWidth = 0.25
        UIColor.gray.setStroke()
        
        return bezierPath
    }
    
    private func shapePath() -> UIBezierPath {
        
        let lowerPointOffsetX = bounds.width / 12
        let lowerPointOffsetY = bounds.height / 8
        let upperPointOffsetX = bounds.width / 10
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        bezierPath.addLine(to: CGPoint(x: lowerPointOffsetX, y: lowerPointOffsetY))
        
        bezierPath.addQuadCurve(to: CGPoint(x: upperPointOffsetX, y: bounds.minY) ,
                                controlPoint: CGPoint(x: lowerPointOffsetX, y: bounds.minY))
        bezierPath.addLine(to: CGPoint(x: bounds.width - upperPointOffsetX, y: bounds.minY))
        bezierPath.addQuadCurve(to: CGPoint(x: bounds.width - lowerPointOffsetX, y: lowerPointOffsetY) ,
                                controlPoint: CGPoint(x: bounds.width - lowerPointOffsetX, y: bounds.minY))
        bezierPath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        
        UIColor.normalState().setFill()
        bezierPath.fill()
        UIColor.black.setStroke()
        bezierPath.lineWidth = 0.25
        bezierPath.stroke()
        
        return bezierPath
    }
    
    override func draw(_ rect: CGRect) {
        shapePath().stroke()
    }
}

