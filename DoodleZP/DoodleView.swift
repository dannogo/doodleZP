//
//  DoodleView.swift
//  DoodleZP
//
//  Created by admin on 2/3/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

@IBDesignable
class DoodleView: UIView {
    
    var currentElements = [NSValue:Element]()
    var finishedElements = [Element]()
    var selectedElementIndex: Int?
    
    required init?(coder aDecored: NSCoder) {
        super.init(coder: aDecored)
        
        
    }
    
    
    override func willRemoveSubview(_ subview: UIView) {
        //
    }
    
    override func didAddSubview(_ subview: UIView) {
        //
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
