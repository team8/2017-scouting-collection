//
//  Button.swift
//  2017 Scouting Collection
//
//  Created by Alex Tarng on 12/29/16.
//  Copyright © 2016 Paly Robotics. All rights reserved.
//

import Foundation
import UIKit

class Button: UIButton {
    
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
        self.backgroundColor = UIColor.clear
        self.setTitleColor(UIColor.white, for: .normal)
        super.touchesEnded(touches, with: event)
    }
    
    func enable() {
        self.layer.borderColor = UIColor.white.cgColor
        self.setTitleColor(UIColor.white, for: .normal)
        self.isEnabled = true
    }
    
    func disable() {
        self.layer.borderColor = UIColor.lightText.cgColor
        self.setTitleColor(UIColor.lightText, for: .normal)
        self.isEnabled = false
    }
}
