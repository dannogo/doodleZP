//
//  DrawingStates.swift
//  DoodleZP
//
//  Created by Oleh Liskovych on 5/14/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

class DrawingStates {

    
    // if selected lines mode, unselect color and thickness buttons
    
    private init() {}
    static let shared: DrawingStates = DrawingStates()
    
    var lineStateView: LineStateView? {
        willSet {
            newValue?.thickness = DrawingStates.thicknesses[self.thicknessIndex]
            newValue?.color = DrawingStates.colors[self.colorIndex]
        }
    }
    
    var doodleView: DoodleView? {
        willSet {
            newValue?.currentColor = DrawingStates.colors[self.colorIndex]
            newValue?.currentThickness = DrawingStates.thicknesses[self.thicknessIndex]
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
    var colorIndex = 8 {
        willSet {
            let newColor = DrawingStates.colors[newValue]
            lineStateView?.color = newColor
            doodleView?.currentColor = newColor
        }
    }
    var thicknessIndex = 3  {
        willSet {
            let newThickness = DrawingStates.thicknesses[newValue]
            lineStateView?.thickness = newThickness
            doodleView?.currentThickness = newThickness
        }
    }
    var isVectorMode = true
    
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
