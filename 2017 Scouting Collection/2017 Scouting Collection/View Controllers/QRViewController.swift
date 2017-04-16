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
    
//    var TextTOQRCode : String = ""
    var data: DataModel?
    
    override func viewDidLoad() {
        
        let TextTOQRCode = data!.CSV()
        
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
//            DataModel.currentData!.clearData()
            self.performSegue(withIdentifier: "unwindQRToHome", sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func rescoutPressed(_ sender: Any) {
        if data!.data["comp_level"] as! String == "pr" {
            let alert = UIAlertController(title: "Unable to Rescout", message: "You cannot rescout a practice match. Finish and scout a new pratice match.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Rescout Confirmation", message: "Are you sure you want to rescout this match? When you finish scouting, it will overwrite the previous data.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
                self.performSegue(withIdentifier: "QRToPrematch", sender: self.data!.getMatch()!)
            }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "QRToPrematch") {
            let secondViewController = segue.destination as! HomeViewController
            let match = sender as! MatchModel
            secondViewController.match = match
        }
    }
}
