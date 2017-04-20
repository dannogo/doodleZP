//
//  Line.swift
//  DoodleZP
//
//  Created by admin on 2/7/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import Foundation
import UIKit

class Line: NSObject, NSCopying {
    
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
//        associateLineWithPoints()
    }
    
    convenience init(sender shape: Vector, start: Point, end: Point, color: UIColor, thickness: CGFloat, anyNumber: Int) {
        self.init(sender: shape, start: start, end: end, color: color, thickness: thickness)
        associateLineWithPoints()
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Line(sender: self.shape, start: self.start.copy() as! Point, end: self.end.copy() as! Point, color: self.color, thickness: self.thickness, anyNumber: 0)
        return copy
    }
    
    func associateLineWithPoints() {
        start.lines.append( NSValue(nonretainedObject: self) )
        end.lines.append( NSValue(nonretainedObject: self) )
    }

}
