//
//  Line.swift
//  DoodleZP
//
//  Created by admin on 2/7/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import Foundation
import UIKit

class Line {
    
    init(sender shape: Vector, start: Point, end: Point, color: UIColor, thickness: CGFloat) {
        self.shape = shape
        self.start = start
        self.end = end
        self.color = color
        self.thickness = thickness
    }
    
    // strong reference cycle
    var shape: Vector
    var start: Point
    var end: Point
    var color: UIColor
    var thickness: CGFloat
    
}
