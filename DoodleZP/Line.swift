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
    
    var shape: Vector
    var start: Point
    var end: Point
    var color: UIColor
    var thickness: CGFloat
    
    init(sender shape: Vector, start: Point, end: Point, color: UIColor, thickness: CGFloat) {
        self.shape = shape
        self.start = start
        self.end = end
        self.color = color
        self.thickness = thickness
        associateLineWithPoints()
    }
    
    func associateLineWithPoints() {
        start.lines.append( NSValue(nonretainedObject: self) )
        end.lines.append( NSValue(nonretainedObject: self) )
    }

}
