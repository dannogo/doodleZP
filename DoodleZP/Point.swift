//
//  Point.swift
//  DoodleZP
//
//  Created by admin on 2/7/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import Foundation
import UIKit

class Point: NSObject, NSCopying {
    
    let id: UUID
    var lines: [NSValue?] = []
    var point: CGPoint
    
    init(_ point: CGPoint, id: UUID) {
        self.point = point
        self.id = id
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Point(self.point, id: self.id)
        copy.lines = lines
        return copy
    }
    
}
