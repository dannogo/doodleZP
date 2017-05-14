//
//  LineStateView.swift
//  DoodleZP
//
//  Created by Oleh Liskovych on 5/14/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

class LineStateView: UIView {
    
    private var thickness: CGFloat
    private var color: UIColor
    
    init(thickness: CGFloat, color: UIColor) {
        self.thickness = thickness
        self.color = color
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func drawStatusPath() -> UIBezierPath {
     
        return UIBezierPath()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
