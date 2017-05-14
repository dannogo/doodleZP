//
//  DrawingStates.swift
//  DoodleZP
//
//  Created by Oleh Liskovych on 5/14/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

class DrawingStates {

    static let shared = DrawingStates()
    private static let setup = SingletonSetupHelper()
    
    class func setup(param: String){
        DrawingStates.setup.param = param
    }
    
    private init() {
        let param = DrawingStates.setup.param
        guard param != nil else {
            fatalError("Error - you must call setup before accessing DrawingStates.shared")
        }
    }
    
//    var availableGratingFrequencies: [Int]
//    var availableColors: [UIColor]
//    var availableThicknesses: [CGFloat]
//    
//    var isPointEditingMode: Bool
//    var isFixedAnglesMode: Bool
//    var isGlueMode: Bool
//    var isEraserMode: Bool
}

private class SingletonSetupHelper {
    var param: String?
}
