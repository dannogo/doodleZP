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

    var toolsPanel: ToolsPanel = ToolsPanel()
    
    var doodleView = DoodleView()
    
    // MARK - Enums
    enum GraphicMode {
        case vector, raster
    }
    
    enum VectorModes {
        case none, step45percent, aligningToPoints, aligningToGridNodes,
            singleLinePicked, multipleLinesPicked, linePointsEditing, regularPanning
    }
    
    func btnTap() {
        print("tap")
    }

    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toolsPanel = ToolsPanel()
        toolsPanel.translatesAutoresizingMaskIntoConstraints = false
        
        let btn = ToolsPanelButton(random: true)
        btn.setTitle("HUY!", for: .normal)
        btn.addTarget(self, action: #selector(self.btnTap), for: .touchUpInside)
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.blue.cgColor
        btn.layer.backgroundColor = UIColor.gray.cgColor
        self.view.addSubview(btn)
        
        self.view.addSubview(toolsPanel)
        toolsPanel.orientation = .portrait
        toolsPanel.backgroundColor = UIColor.green
        
        NSLayoutConstraint.activate([
            btn.widthAnchor.constraint(equalToConstant: 100),
            btn.heightAnchor.constraint(equalToConstant: 120),
            btn.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            btn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
            ])
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
