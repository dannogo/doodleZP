//
//  DoodleController.swift
//  DoodleZP
//
//  Created by admin on 2/3/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit



class DoodleController: UIViewController, UIPopoverPresentationControllerDelegate {
    
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
    static var toolbarIsShown = true
    
    
    // MARK - Enums
    enum GraphicMode {
        case vector, raster
    }
    
    enum VectorModes {
        case none, step45percent, aligningToPoints, aligningToGridNodes,
            singleLinePicked, multipleLinesPicked, linePointsEditing, regularPanning
    }
    
//    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
//        return UIModalPresentationStyle.none
//    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        // return UIModalPresentationStyle.FullScreen
        return UIModalPresentationStyle.none
    }
    
    func showPopover(base: UIView)
    {
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "popover") as? PopOverViewController {
            
            
            viewController.modalPresentationStyle = .popover
            if let pctrl = viewController.popoverPresentationController {
                pctrl.delegate = self
                
                pctrl.sourceView = base
                pctrl.sourceRect = base.bounds
                
                self.present(viewController, animated: true, completion: nil)
            }
            
//            let navController = UINavigationController(rootViewController: viewController)
//            navController.modalPresentationStyle = .popover
//            
//            if let pctrl = navController.popoverPresentationController {
//                pctrl.delegate = self
//                
//                pctrl.sourceView = base
//                pctrl.sourceRect = base.bounds
//                
//                self.present(navController, animated: true, completion: nil)
//            }
        }
    }

    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        toolsPanel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(toolsPanel)
        toolsPanel.orientation = .portrait
        
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
