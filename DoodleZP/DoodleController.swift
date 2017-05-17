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
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    func showPopover(base: ToolsPanelButton)
    {
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "popover") as? PopOverViewController {
            
            viewController.type = base.type
            
            viewController.modalPresentationStyle = .popover
            if let popupController = viewController.popoverPresentationController {
                popupController.permittedArrowDirections = .down
                popupController.popoverBackgroundViewClass = PopupMenuBackgroundView.classForCoder() as? UIPopoverBackgroundViewMethods.Type
                
                popupController.delegate = self
                
                popupController.sourceView = base
                popupController.sourceRect = base.bounds
                
                self.present(viewController, animated: true, completion: nil)
            }
        }
    }

    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        toolsPanel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(toolsPanel)
        toolsPanel.orientation = .portrait
        let drawingStates = DrawingStates.sharedInstance
        let lineStateView = LineStateView(superview: self.view,
                                          thickness: DrawingStates.thicknesses[drawingStates.thicknessIndex],
                                          color: DrawingStates.colors[drawingStates.colorIndex])
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
