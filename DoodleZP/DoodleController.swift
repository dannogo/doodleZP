//
//  DoodleController.swift
//  DoodleZP
//
//  Created by admin on 2/3/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

class DoodleController: UIViewController {
    
    /*
     orientation - in Separated ViewController
     
     
     Universal:
     - back in history
     - brush thickness with subpanel
     - color with subpanel
     - convert to raster with alert
     - hand for regular panning active-inactive
     - grid with subpanel
     
     
     Vector:
     - step45percent
     - aligningToPoints
     - aligningToGridNodes
     - singleLinePicked
     - multipleLinesPicked
     - linePointsEditing
     - regularPanning
     - front, back, forward, backward  in singleLinePicked mode
     
     
     Raster:
     - set background image
     - eraser
     
     
     
     While doing every action, record it as a chainLink
     */
    

//    let toolsPanel: ToolsPanel = ToolsPanel(frame: CGRect(x: 20, y: 20, width: 150, height: 150))
    let toolsPanel: ToolsPanel = ToolsPanel()
    
    
    // MARK - Enums
    enum GraphicMode {
        case vector, raster
    }
    
    enum VectorModes {
        case none, step45percent, aligningToPoints, aligningToGridNodes,
            singleLinePicked, multipleLinesPicked, linePointsEditing, regularPanning
    }
    
//    enum RasterModes {
//        case none,
//    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(toolsPanel)
        toolsPanel.orientation = .portrait
        toolsPanel.backgroundColor = UIColor.gray
        // Do any additional setup after loading the view.
        toolsPanel.layer.backgroundColor = UIColor.red.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: {(UIViewControllerTransitionCoordinatorContext) -> Void in
            
            let orient = UIApplication.shared.statusBarOrientation
            self.toolsPanel.orientation = orient
            
            switch orient {
            case .portrait:
                print("Portrait")
            case .landscapeLeft:
                print("Landscape left")
            case .landscapeRight:
                print("Landscape right")
            case .portraitUpsideDown:
                print("Portrait upside down")
            case .unknown:
                print("Orientation unknown")
            }
            
            }, completion: {(UIViewControllerTransitionCoordinatorContext) -> Void in
                //Show previously opened subpanel if one was opened
//                    print("Rotation completed")
                })
        
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    
}
