//
//  PopOverViewController.swift
//  DoodleZP
//
//  Created by Oleh Liskovych on 5/4/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

class PopOverViewController: UIViewController {
    
    static let colorButtons: [PopupMenuButton] = {
        var result = [PopupMenuButton]()
        for color in DrawingStates.colors {
            let colorButton = PopupMenuButton(type: .palette, color: color)
            colorButton.addTarget(self, action: #selector(self.btnTap), for: .touchUpInside)
            result.append(colorButton)
        }
        return result
    }()
    
    static let thicknessButtons: [PopupMenuButton] = {
        var result = [PopupMenuButton]()
        for thickness in DrawingStates.thicknesses {
            let thicknessButton = PopupMenuButton(type: .thickness, thickness: thickness)
            thicknessButton.addTarget(self, action: #selector(self.btnTap), for: .touchUpInside)
            result.append(thicknessButton)
        }
        
        return result
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.superview?.layer.cornerRadius = 0
    }
    
    static var buttonSize = 46.875
    
    var type: ToolsPanelButton.ActionType?
    
    
    func btnTap (_ sender: PopupMenuButton) {
        // select this button
        // deselect previously selected one
        // make sure line status view and drawing mode have changed in DrawingStates
        let drawingStates = DrawingStates.sharedInstance
        switch sender.type {
        case .palette:
            // Remember somewhere in DrawingStates. Or handle it right there
            colorButtons[drawingStates.colorIndex].setDeselectedState()
            drawingStates.colorIndex = colorButtons.index(of:sender)
        case .thickness:
            // Remember somewhere in DrawingStates
            thicknessButtons[drawingStates.thicknessIndex].setDeselectedState()
            drawingStates.thicknessIndex = thicknessButtons.index(of:sender)
        default:
            break
        }
        sender.setSelectedState()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = PopOverViewController.buttonSize
        let height: Double
        let buttons: [PopupMenuButton]
        
//        let height = type! == .palette ? width * Double(PopOverViewController.colorButtons.count) : width * Double(PopOverViewController.thicknessButtons.count)
        
        switch type! {
        case .palette:
            height = width * Double(PopOverViewController.colorButtons.count)
            buttons = PopOverViewController.colorButtons
        case .thickness:
            height = width * Double(PopOverViewController.thicknessButtons.count)
            buttons = PopOverViewController.thicknessButtons
        default:
            height = width * Double(PopOverViewController.colorButtons.count)
            buttons = PopOverViewController.colorButtons
            break
        }
        
        
        self.preferredContentSize = CGSize(width: width, height: height)
        
//        createButtons()
        setupButtons(buttons)
    
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.dismiss(sender:)))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismiss(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupButtons(_ buttons: [PopupMenuButton]) {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            container.topAnchor.constraint(equalTo: self.view.topAnchor),
            container.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
        
        for (index, button) in buttons.enumerated() {
            
            container.addSubview(button)
            
            var bottomConstraint: NSLayoutConstraint
            
            if index == 0 {
                bottomConstraint = button.bottomAnchor.constraint(equalTo: container.bottomAnchor)
            } else {
                bottomConstraint = button.bottomAnchor.constraint(equalTo: container.subviews[index-1].topAnchor)
            }
            
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: CGFloat(PopOverViewController.buttonSize)),
                button.heightAnchor.constraint(equalToConstant: CGFloat(PopOverViewController.buttonSize)),
                button.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                bottomConstraint
                ])
            
        }
    }
    
    @available(*, deprecated)
    private func createButtons () {
        print("subviews.count before: \(self.view.subviews.count)")
        var buttons = [PopupMenuButton]()
        switch type! {
        case .palette:
            for color in DrawingStates.colors {
                buttons.append(PopupMenuButton(type: type!, color: color))
                print("colors button count: \(buttons.count)")
            }
        case .thickness:
            for thickness in DrawingStates.thicknesses {
                buttons.append(PopupMenuButton(type: type!, thickness: thickness))
                print("thickness button count: \(buttons.count)")
            }
        default:
            break
        }
        
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            container.topAnchor.constraint(equalTo: self.view.topAnchor),
            container.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
        
        for (index, button) in buttons.enumerated() {
            
            container.addSubview(button)
            
            var bottomConstraint: NSLayoutConstraint
            
            if index == 0 {
                bottomConstraint = button.bottomAnchor.constraint(equalTo: container.bottomAnchor)
            } else {
                bottomConstraint = button.bottomAnchor.constraint(equalTo: container.subviews[index-1].topAnchor)
            }
            
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 46.875),
                button.heightAnchor.constraint(equalToConstant: 46.875),
                button.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                bottomConstraint
                ])
            
        }
        
    }
    
    func listSubviewsOfView(view:UIView){
        
        // Get the subviews of the view
        let subviews = view.subviews
        
        // Return if there are no subviews
        if subviews.count == 0 {
            return
        }
        
        for subview : AnyObject in subviews{
            
            // Do what you want to do with the subview
            print(subview)
            
            // List the subviews of subview
            listSubviewsOfView(view: subview as! UIView)
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        
//    }
 

}
