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

class QRCodeViewController : ViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var qrC: UIImageView?
    @IBOutlet weak var teamMatchLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
//    var TextTOQRCode : String = ""
    var data: DataModel?
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        
//        let mutableArray =
        let sortedKeyArray = Array(data!.data.keys).sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        let key = sortedKeyArray[indexPath.row]
        let val = data!.data[key]!
        
        cell.textLabel?.text = key + ": " + String(describing: val)
        
        cell.textLabel?.numberOfLines=0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data!.data.count
    }
}
