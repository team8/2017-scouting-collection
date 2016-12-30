//
//  ToggleButton.swift
//  2017 Scouting Collection
//
//  Created by Alex Tarng on 12/29/16.
//  Copyright © 2016 Paly Robotics. All rights reserved.
//

import Foundation
import UIKit

class ToggleButton: UIButton {
    
    var toggleState = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.backgroundColor = UIColor.white
            self.setTitleColor(UIColor(red:0.07, green:0.46, blue:0.07, alpha:1.0), for: .normal)
        })
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.backgroundColor = UIColor.clear
        self.setTitleColor(UIColor.white, for: .normal)
        super.touchesCancelled(touches, with: event)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.toggleState) {
            self.toggleState = false
            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                self.backgroundColor = UIColor.clear
                self.setTitleColor(UIColor.white, for: .normal)
            })
        } else {
            self.toggleState = true
            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                self.backgroundColor = UIColor.white
                self.setTitleColor(UIColor(red:0.07, green:0.46, blue:0.07, alpha:1.0), for: .normal)
            })
        }
        super.touchesEnded(touches, with: event)
    }
    
    func toggle(toggleState: Bool) {
        self.toggleState = toggleState
        if (toggleState) {
            self.backgroundColor = UIColor.white
            self.setTitleColor(UIColor(red:0.07, green:0.46, blue:0.07, alpha:1.0), for: .normal)
        } else {
            self.backgroundColor = UIColor.clear
            self.setTitleColor(UIColor.white, for: .normal)
        }
    }
}
