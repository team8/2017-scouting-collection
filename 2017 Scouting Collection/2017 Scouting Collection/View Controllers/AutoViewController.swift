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
    
    @IBOutlet weak var reachButton: UIButton!
    
    @IBOutlet weak var lowGoalSuccess: UILabel!
    @IBOutlet weak var lowGoalFailure: UILabel!
    @IBOutlet weak var highGoalSuccess: UILabel!
    @IBOutlet weak var highGoalFailure: UILabel!
    
    @IBOutlet weak var lowBarSuccess: UILabel!
    @IBOutlet weak var lowBarFailure: UILabel!
    @IBOutlet weak var def1Success: UILabel!
    @IBOutlet weak var def1Failure: UILabel!
    @IBOutlet weak var def2Success: UILabel!
    @IBOutlet weak var def2Failure: UILabel!
    @IBOutlet weak var def3Success: UILabel!
    @IBOutlet weak var def3Failure: UILabel!
    @IBOutlet weak var def4Success: UILabel!
    @IBOutlet weak var def4Failure: UILabel!
    
    @IBAction func autoUnwind(unwindSegue: UIStoryboardSegue) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    @IBAction func toggleButtonPressed(_ sender: ToggleButton) {
        switch(sender.tag) {
            case 0:
                //Drive
                Data.currentMatch?.drive = sender.toggleState
                break
            case 1:
                //No Action
                Data.currentMatch?.noAction = sender.toggleState
                break
            case 2:
                //Broken Down
                Data.currentMatch?.brokeDown = sender.toggleState
                break
            case 3:
                //Collision
                Data.currentMatch?.collision = sender.toggleState
                break
            case 4:
                //Reach
                Data.currentMatch?.reach = sender.toggleState
                break
            default:
                //wat
                break
        }
    }
    
    @IBAction func SFButtonPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SFDialogViewController") as! SFDialogViewController
        vc.parentValue = sender.tag
        self.present(vc, animated: false, completion: nil)
    }
    
    func reloadData() {
        if (Data.currentMatch?.reach)! {
            self.reachButton.backgroundColor = UIColor.white
            self.reachButton.setTitleColor(UIColor(red:0.07, green:0.46, blue:0.07, alpha:1.0), for: .normal)
        } else {
            self.reachButton.backgroundColor = UIColor.clear
            self.reachButton.setTitleColor(UIColor.white, for: .normal)
        }
        self.lowGoalSuccess.text = "S: " + String(describing: Data.currentMatch!.autoLowGoalSuccess)
        self.lowGoalFailure.text = "F: " + String(describing: Data.currentMatch!.autoLowGoalFailure)
        self.highGoalSuccess.text = "S: " + String(describing: Data.currentMatch!.autoHighGoalSuccess)
        self.highGoalFailure.text = "F: " + String(describing: Data.currentMatch!.autoHighGoalFailure)
        self.lowBarSuccess.text = "S: " + String(describing: Data.currentMatch!.autoLowBarSuccess)
        self.lowBarFailure.text = "F: " + String(describing: Data.currentMatch!.autoLowBarFailure)
        self.def1Success.text = "S: " + String(describing: Data.currentMatch!.autoDef1Success)
        self.def1Failure.text = "F: " + String(describing: Data.currentMatch!.autoDef1Failure)
        self.def2Success.text = "S: " + String(describing: Data.currentMatch!.autoDef2Success)
        self.def2Failure.text = "F: " + String(describing: Data.currentMatch!.autoDef2Failure)
        self.def3Success.text = "S: " + String(describing: Data.currentMatch!.autoDef3Success)
        self.def3Failure.text = "F: " + String(describing: Data.currentMatch!.autoDef3Failure)
        self.def4Success.text = "S: " + String(describing: Data.currentMatch!.autoDef4Success)
        self.def4Failure.text = "F: " + String(describing: Data.currentMatch!.autoDef4Failure)
    }
}
