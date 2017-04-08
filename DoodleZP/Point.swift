//
//  Point.swift
//  DoodleZP
//
//  Created by admin on 2/7/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import Foundation
import UIKit

class Point {
    
    let id = UUID()
    
    init(_ point: CGPoint) {
        self.point = point
    }
    
    var lines: [NSValue?] = []
    var point: CGPoint
    
}
