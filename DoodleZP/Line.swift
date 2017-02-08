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
    
    init(start: Point, end: Point, color: UIColor, thickness: CGFloat) {
        self.start = start
        self.end = end
        self.color = color
        self.thickness = thickness
    }
    
    var start: Point
    var end: Point
    var color: UIColor
    var thickness: CGFloat
    
}
