//
//  AutoViewController.swift
//  2017 Scouting Collection
//
//  Created by Alex Tarng on 12/24/16.
//  Copyright © 2016 Paly Robotics. All rights reserved.
//

import Foundation
import UIKit

class AutoViewController: ViewController {
    
    @IBOutlet weak var currentPeriod: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    var contentViewMaxHeight = 493
    
    @IBOutlet weak var gearButton: UIImageView!
    @IBOutlet weak var gearView: UIView!
    @IBOutlet weak var gearViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var pressureButton: UIButton!
    @IBOutlet weak var pressureView: UIView!
    @IBOutlet weak var pressureViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var fuelButton: UIImageView!
    @IBOutlet weak var fuelView: UIView!
    @IBOutlet weak var fuelViewConstraint: NSLayoutConstraint!
    
    var timeLeftTimer: Timer!
    var timePassed : Int = 0
    var isAuto = true
    
    override func viewDidLoad() {
        timeLeftTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
        
    }
    func updateLabel() {
        timePassed += 1
        if timePassed > 20{
            isAuto = false
            currentPeriod.text = "Teleop"
        }
        if isAuto{
            timerLabel.text = "\(timePassed)"
        }else{
            let rawSeconds =  timePassed - 20
            let minutes = floor(Double(rawSeconds / 60))
            let seconds = Double(rawSeconds)  - (minutes * 60)
            if seconds > 10{
                timerLabel.text = "\(Int(minutes)):\(Int(seconds))"
            }else{
                timerLabel.text = "\(Int(minutes)):0\(Int(seconds))"
            }
            
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Insets for the images
        let insets = UIEdgeInsets(top: 25, left: 0, bottom: 25, right: 0)
        
        let gearImage = UIImage(named: "gears")!
        gearButton.image = gearImage.imageWithInsets(insets: insets)
        
        let fuelImage = UIImage(named: "fuel-intake")
        fuelButton.image = fuelImage?.imageWithInsets(insets: insets)
        
        //Tap recognizers for imageView
        let gearTap = UITapGestureRecognizer(target: self, action: #selector(AutoViewController.gearButtonTapped()))
        gearButton.addGestureRecognizer(gearTap)
        gearButton.isUserInteractionEnabled = true
        
        let fuelTap = UITapGestureRecognizer(target: self, action: #selector(AutoViewController.fuelButtonTapped()))
        fuelButton.addGestureRecognizer(fuelTap)
        fuelButton.isUserInteractionEnabled = true
        
        //Hiding all of the content views
        
        
        
        
//        gearButton.backgroundColor = UIColor(colorLiteralRed: 60/255, green: 110/255, blue: 113/255, alpha: 1)
        
    }
    func gearButtonTapped(){
        
    }
    func fuelButtonTapped(){
        
    }
}
extension UIImage {
    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let _ = UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }
}
