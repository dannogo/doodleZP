//
//  DrawingStates.swift
//  DoodleZP
//
//  Created by Oleh Liskovych on 5/14/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

class DrawingStates {

    private init() {}
    static let sharedInstance: DrawingStates = DrawingStates()
    
    static var colors = [
        UIColor.black,
        UIColor.blue,
        UIColor.brown,
        UIColor.cyan,
        UIColor.darkGray,
        UIColor.green,
        UIColor.magenta
    ]
    
    static var thicknesses: [CGFloat] = {
        
        var result = [CGFloat]()
        var i: CGFloat = 1
        
        repeat {
            result.append(i)
            i += 2
        } while (i < 13)
        
        return result
    }()
    
    private var grateIndex = 0 {
        didSet {
            // change line status view
            // change selected grate in popup
            // handle in doodle view
            // add dismiss grate
        }
    }
    var colorIndex = 0 {
        didSet {
            // change line status view
            // change selected color in popup
            // handle in doodle view
        }
    }
    var thicknessIndex = 0  {
        didSet {
            // change line status view
            // change selected thickness in popup
            // handle in doodle view
        }
    }
    private var isVectorMode = true  {
        didSet {
            // move toolspanel changes here
            // handle in doodle view
        }
    }
    private var isRasterMode = false  {
        didSet {
            // move toolspanel changes here
            // handle in doodle view
        }
    }
    private var isPointEditingMode = false  {
        didSet {
            // select icon on toolspanel
            // handle in doodle view
        }
    }
    private var isFixedAnglesMode = false  {
        didSet {
            // select icon on toolspanel
            // handle in doodle view
        }
    }
    private var isGlueMode = false  {
        didSet {
            // select icon on toolspanel
            // handle in doodle view
        }
    }
    private var isEraserMode = false  {
        didSet {
            // select icon on toolspanel
            // handle in doodle view
        }
    }
}
