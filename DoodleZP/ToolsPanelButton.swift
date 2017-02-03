//
//  ToolsPanelButton.swift
//  DoodleZP
//
//  Created by admin on 2/3/17.
//  Copyright © 2017 Oleh. All rights reserved.
//

import UIKit

class ToolsPanelButton: UIButton {
    
    let hint: String
    let icon: UIImage? = nil
    let action: (() -> ())? = nil
    
    init(frame: CGRect, hint: String) {
        self.hint = hint
        super.init(frame: frame)
    }
    
    static var dummyCount = 0
    
    convenience init(random: Bool) {
        if random {
            ToolsPanelButton.dummyCount += 1
            self.init(frame: CGRect.zero, hint: String(ToolsPanelButton.dummyCount))
        } else {
            self.init(frame: CGRect.zero, hint: "")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
