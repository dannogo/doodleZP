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
        for color in colors {
            result.append(PopupMenuButton(type: .palette, color: color))
        }
        return result
    }()
    
    static let thicknessButtons: [PopupMenuButton] = {
        var result = [PopupMenuButton]()
        for thickness in thicknesses {
            result.append(PopupMenuButton(type: .thickness, thickness: thickness))
        }
        
        return result
    }()
    
    private static var colors = [
        UIColor.black,
        UIColor.blue,
        UIColor.brown,
        UIColor.cyan,
        UIColor.darkGray,
        UIColor.green,
        UIColor.magenta
    ]
    
    private static var thicknesses: [CGFloat] = {
        
        var result = [CGFloat]()
        var i: CGFloat = 1
        for _ in 0..<10 {
            i *= 1.25
            result.append(i)
        }
        
        return result
    }()
    
    static var buttonSize = 46.875
    
    var type: ToolsPanelButton.ActionType?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.preferredContentSize = CGSize(width: 46.875, height: 46.875 * 10)
        
        createButtons()
    
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
    
    private func createButtons () {
        print("subviews.count before: \(self.view.subviews.count)")
        var buttons = [PopupMenuButton]()
        switch type! {
        case .palette:
            for color in PopOverViewController.colors {
                buttons.append(PopupMenuButton(type: type!, color: color))
                print("colors button count: \(buttons.count)")
            }
        case .thickness:
            for thickness in PopOverViewController.thicknesses {
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