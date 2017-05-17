//
//  PopupMenuButton.swift
//  DoodleZP
//
//  Created by Oleh Liskovych on 5/6/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

class PopupMenuButton: UIButton {

    let type: ToolsPanelButton.ActionType
    private let color: UIColor
    private let thickness: CGFloat
    private let radius: CGFloat = 8.0
    
    
    private var buttonCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    init(type: ToolsPanelButton.ActionType, color: UIColor = UIColor.darkGray, thickness: CGFloat = 3.0) {
        self.type = type
        self.color = color
        self.thickness = thickness
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtons() {
        
        let selectedKey = type.rawValue + NotificationCenterKeys.optionString + NotificationCenterKeys.selected
        let deselectedKey = type.rawValue + NotificationCenterKeys.optionString + NotificationCenterKeys.deselected
        
        NotificationCenter.default.addObserver(self, selector: #selector(PopupMenuButton.setSelectedState), name: NSNotification.Name(rawValue: selectedKey), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PopupMenuButton.setDeselectedState), name: NSNotification.Name(rawValue: deselectedKey), object: nil)
        
        self.layer.borderWidth = 0.25
        self.layer.borderColor = UIColor.gray.cgColor
        if self.isSelected {
            self.layer.backgroundColor = UIColor.selectedState().cgColor
        } else {
            self.layer.backgroundColor = UIColor.normalState().cgColor
        }
        
    }
    
    override var isSelected: Bool {
        willSet {
            self.layer.backgroundColor = newValue ? UIColor.selectedState().cgColor : UIColor.normalState().cgColor
        }
    }
    
    func setSelectedState() {
        self.isSelected = true
    }
    
    func setDeselectedState() {
        self.isSelected = false
    }
    
    private func pathForCircleCenteredAtPoint(midPoint: CGPoint, withRadius radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath(
            arcCenter: midPoint,
            radius: radius,
            startAngle: 0.0,
            endAngle: CGFloat(2*Double.pi),
            clockwise: false
        )
        path.fill()
        return path
    }
    
    private func pathForLine() -> UIBezierPath {
        let path = UIBezierPath()
        let inset: CGFloat = 8.0
        path.move(to: CGPoint(x: inset, y: bounds.midY))
        path.addLine(to: CGPoint(x: bounds.width-inset, y: bounds.midY))
        path.lineWidth = thickness
        
        return path
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        color.set()
        switch type {
        case .palette:
            pathForCircleCenteredAtPoint(midPoint: buttonCenter, withRadius: radius).stroke()
        case .thickness:
            pathForLine().stroke()
        default:
            break
        }
        
    }
    
    

}
