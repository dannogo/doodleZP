//
//  PopOverViewController.swift
//  DoodleZP
//
//  Created by Oleh Liskovych on 5/4/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

class PopOverViewController: UIViewController {

    lazy var colors = [
        UIColor.black,
        UIColor.blue,
        UIColor.brown,
        UIColor.cyan,
        UIColor.darkGray,
        UIColor.green,
        UIColor.magenta
    ]
    
    lazy var thicknesses: [CGFloat] = {
        
        var result = [CGFloat]()
        var i: CGFloat = 1
        for _ in 0..<10 {
            i *= 1.1
            result.append(i)
        }
        
        return result
    }()
    
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
        var buttons = [PopupMenuButton]()
        switch type! {
        case .palette:
            for color in colors {
                buttons.append(PopupMenuButton(type: type!, color: color))
            }
        case .thickness:
            for thickness in thicknesses {
                buttons.append(PopupMenuButton(type: type!, thickness: thickness))
            }
        default:
            break
        }
        
        for (index, button) in buttons.enumerated() {
            self.view.addSubview(button)
            
            var bottomConstraint: NSLayoutConstraint
            
            if index == 0 {
                bottomConstraint = button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            } else {
                bottomConstraint = button.bottomAnchor.constraint(equalTo: self.view.subviews[index-1].topAnchor)
            }
            
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 46.875),
                button.heightAnchor.constraint(equalToConstant: 46.875),
                button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                bottomConstraint
                ])
            
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
