//
//  Vector.swift
//  DoodleZP
//
//  Created by admin on 2/7/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import Foundation
import UIKit

class Vector: Element {
    
    let id = UUID()
    var layerIndex: Int?
    
    var lines: [Line] = []
    
    @discardableResult func createLine(start: Point, end: Point, color: UIColor, thickness: CGFloat) -> Line {
        let line = Line(sender: self, start: start, end: end, color: color, thickness: thickness)
        lines.append(line)
        return line
    }
    
}
