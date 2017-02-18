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

    
    var toolsPanel: ToolsPanel = ToolsPanel(frame: CGRect(x: 40, y: 40, width: 300, height: 200))
    
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
        
        toolsPanel = ToolsPanel(frame: CGRect(x: 40, y: 40, width: 300, height: 200))
        toolsPanel.translatesAutoresizingMaskIntoConstraints = false
        
        let btn = ToolsPanelButton(random: true)
        btn.setTitle("HUY!", for: .normal)
        let size = CGRect(x: 200, y: 300, width: 50, height: 50)
        //            btn.frame.size.height = buttonSize
        //            btn.frame.size.width = buttonSize
        btn.frame = size
        btn.addTarget(self, action: #selector(self.btnTap), for: .touchUpInside)
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.blue.cgColor
        btn.layer.backgroundColor = UIColor.gray.cgColor
        self.view.addSubview(btn)
        
        self.view.addSubview(toolsPanel)
        toolsPanel.orientation = .portrait
        toolsPanel.backgroundColor = UIColor.green
        
        //    TRY
//        let leadingConstraint = toolsPanel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
//        let bottomConstraint = toolsPanel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
//        
//        toolsPanel.addConstraint(leadingConstraint)
//        toolsPanel.addConstraint(bottomConstraint)
//        leadingConstraint.isActive = true
//        bottomConstraint.isActive = true
        
        let  widthConstraint = NSLayoutConstraint(item: toolsPanel,
                attribute: NSLayoutAttribute.width,
                relatedBy: NSLayoutRelation.equal,
                toItem: nil,
                attribute: NSLayoutAttribute.notAnAttribute,
                multiplier: 1,
                constant: 100)
        let heightConstant = NSLayoutConstraint(item: toolsPanel,
                attribute: NSLayoutAttribute.height,
                relatedBy: NSLayoutRelation.equal,
                toItem: nil,
                attribute: NSLayoutAttribute.notAnAttribute,
                multiplier: 1,
                constant: 100)
        
        toolsPanel.addConstraint(widthConstraint)
        toolsPanel.addConstraint(heightConstant)
        
        widthConstraint.isActive = true
        heightConstant.isActive = true
        
        //    TRY
        
        // Do any additional setup after loading the view.
//        toolsPanel.layer.backgroundColor = UIColor.red.cgColor
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
