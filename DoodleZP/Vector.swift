//
//  Vector.swift
//  DoodleZP
//
//  Created by admin on 2/7/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import Foundation
import UIKit

class Vector: NSObject, Element, NSCopying {
    
    var id: UUID
    var layerIndex: Int?
    
    var lines: [Line] = []
    
    init(id: UUID) {
        self.id = id
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Vector(id: self.id)
        copy.layerIndex = self.layerIndex
        for line in self.lines {
            copy.lines.append(line.copy() as! Line)
        }
        return copy
    }
    
    @discardableResult func createLine(id: UUID, start: Point, end: Point, color: UIColor, thickness: CGFloat) -> Line {
        self.id = id
        let line = Line(sender: self, start: start, end: end, color: color, thickness: thickness, anyNumber: 0)
        lines.append(line)
        return line
    }
    
}
