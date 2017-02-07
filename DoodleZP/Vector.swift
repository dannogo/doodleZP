//
//  Vector.swift
//  DoodleZP
//
//  Created by admin on 2/7/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import Foundation

class Vector: Element {
    
    var type: ElementType = .vector
    let id = UUID()
    
    var lines: [Line] = []
    
}
