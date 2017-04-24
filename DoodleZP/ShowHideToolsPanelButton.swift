//
//  ShowHideToolsPanelButton.swift
//  DoodleZP
//
//  Created by Oleh Liskovych on 4/24/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

class ShowHideToolsPanelButton: UIButton {
    
    private var toolsPanel: ToolsPanel?
    private var shapeLayer = CAShapeLayer()
    
    override func didMoveToSuperview() {
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 60),
            self.heightAnchor.constraint(equalToConstant: 35),
//            self.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: bounds.width/2),
//            self.topAnchor.constraint(equalTo: self.topAnchor)
            ])
        
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: bounds.width/2),
            self.bottomAnchor.constraint(equalTo: toolsPanel!.topAnchor)
            ])
        
    }
    
    func setup(with toolsPanel: ToolsPanel) {
        self.toolsPanel = toolsPanel
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setImage(UIImage(named: "hide_tools_panel"), for: .normal)
    }
    
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
    
//    private func shapePath() -> UIBezierPath {
//        
//        let lowerPointOffsetX = bounds.width / 12
//        let lowerPointOffsetY = bounds.height / 8
//        let upperPointOffsetX = bounds.width / 10
//        
//        let bezierPath = UIBezierPath()
//        bezierPath.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
//        bezierPath.addLine(to: CGPoint(x: lowerPointOffsetX, y: lowerPointOffsetY))
//        
//        bezierPath.addQuadCurve(to: CGPoint(x: upperPointOffsetX, y: bounds.minY) ,
//                                controlPoint: CGPoint(x: lowerPointOffsetX, y: bounds.minY))
//        bezierPath.addLine(to: CGPoint(x: bounds.width - upperPointOffsetX, y: bounds.minY))
//        bezierPath.addQuadCurve(to: CGPoint(x: bounds.width - lowerPointOffsetX, y: lowerPointOffsetY) ,
//                                controlPoint: CGPoint(x: bounds.width - lowerPointOffsetX, y: bounds.minY))
//        bezierPath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
//        
//        UIColor.normalState().setFill()
//        bezierPath.fill()
//        UIColor.black.setStroke()
//        bezierPath.lineWidth = 0.25
//        bezierPath.stroke()
//        
//        return bezierPath
//    }
    
    private func setupShape() {
        
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
//        bezierPath.stroke()
        
        let shape = CAShapeLayer()
//        shape.frame = self.bounds
        shape.path = bezierPath.cgPath
        shape.fillColor = UIColor.blue.cgColor
//        self.layer.addSublayer(shape)
        self.layer.insertSublayer(shape, at: 0)
    
    }
    
    override func draw(_ rect: CGRect) {
//        shapePath().stroke()
//        shapeLayer.path
    }
}

