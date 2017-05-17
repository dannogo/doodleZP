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
    
    var lineStateView: LineStateView? {
        willSet {
            newValue?.thickness = DrawingStates.thicknesses[self.thicknessIndex]
            newValue?.color = DrawingStates.colors[self.colorIndex]
        }
    }
    
    static var colors = [
        UIColor.black,
        UIColor.blue,
        UIColor.brown,
        UIColor.cyan,
        UIColor.darkGray,
        UIColor.green,
        UIColor.magenta,
        UIColor.orange,
        UIColor.purple
    ]
    
    static var thicknesses: [CGFloat] = {
        
        var result = [CGFloat]()
        var i: CGFloat = 1
        
        repeat {
            result.append(i)
            i += 2
        } while (i < 15)
        
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
    var colorIndex = 5 {
        didSet {
            // change line status view
            // change selected color in popup
            // handle in doodle view
        }
        willSet {
            lineStateView?.color = DrawingStates.colors[newValue]
        }
    }
    var thicknessIndex = 3  {
        didSet {
            // change line status view
            // change selected thickness in popup
            // handle in doodle view
        }
        willSet {
            lineStateView?.thickness = DrawingStates.thicknesses[newValue]
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
