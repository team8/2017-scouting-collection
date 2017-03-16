//
//  QRViewController.swift
//  2017 Scouting Collection
//
//  Created by Alex Tarng on 12/24/16.
//  Copyright © 2016 Paly Robotics. All rights reserved.
//

import Foundation
import UIKit
import QRCode

class QRCodeViewController : ViewController {
    
    @IBOutlet weak var qrC: UIImageView?
    @IBOutlet weak var teamMatchLabel: UILabel!
    
    var TextTOQRCode : String = ""
    
    override func viewDidLoad() {
        
        let vars = TextTOQRCode.components(separatedBy: ",")
        let team = vars[4]
        let comp_level = vars[1]
        let matchNum = vars[2]
        let matchIn = vars[3]
        
        if (matchIn == "-1") {
            teamMatchLabel.text = "Team " + team + ", " + comp_level + matchNum
        } else {
            teamMatchLabel.text = "Team " + team + ", " + comp_level + matchNum + "m" + matchIn
        }
        
        var qrCode = QRCode(TextTOQRCode)
        qrCode?.size = CGSize(width: 300, height: 300)
        
        qrC?.image = qrCode?.image
    }
    
    @IBAction func finishPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Finish Confirmation", message: "Are you sure you want to finish?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
            DataModel.clearData()
            self.performSegue(withIdentifier: "unwindQRToHome", sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
