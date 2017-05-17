//
//  LineStateView.swift
//  DoodleZP
//
//  Created by Oleh Liskovych on 5/14/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

class LineStateView: UIButton {
    
    static var size: CGFloat = 46.875
    
    var thickness: CGFloat? {
        didSet {
            setNeedsDisplay()
        }
    }
    var color: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    init(superview: UIView, thickness: CGFloat, color: UIColor) {
        self.thickness = thickness
        self.color = color
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(self)
        setupConstraints(superview: superview)
        self.layer.borderWidth = 0.25
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.cornerRadius = 6
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints(superview: UIView) {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: type(of: self).size),
            self.heightAnchor.constraint(equalToConstant: type(of: self).size),
            self.topAnchor.constraint(equalTo: (superview.parentViewController?.topLayoutGuide.bottomAnchor)! , constant: 5),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -5)
            ])
    }
    
    private func drawStatusLine() -> UIBezierPath {
        let path = UIBezierPath()
        let inset: CGFloat = 8.0
        path.move(to: CGPoint(x: inset, y: bounds.midY))
        path.addLine(to: CGPoint(x: bounds.width-inset, y: bounds.midY))
        path.lineWidth = thickness
        
        return path
    }
    
    override func draw(_ rect: CGRect) {
        color.setStroke()
        drawStatusLine().stroke()
    }
    

}
