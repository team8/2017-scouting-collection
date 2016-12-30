//
//  TeleopViewController.swift
//  2017 Scouting Collection
//
//  Created by Alex Tarng on 12/24/16.
//  Copyright © 2016 Paly Robotics. All rights reserved.
//

import Foundation
import UIKit

class TeleopViewController: ViewController {
    
    @IBOutlet weak var driveButton: ToggleButton!
    @IBOutlet weak var noActionButton: ToggleButton!
    @IBOutlet weak var brokeDownButton: ToggleButton!
    
    @IBOutlet weak var shotsBlocked: UILabel!
    
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
    
    @IBAction func teleopUnwind(unwindSegue: UIStoryboardSegue) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    @IBAction func toggleButtonPressed(_ sender: ToggleButton) {
        switch(sender.tag) {
        case 0:
            //Drive
            Data.currentMatch?.teleopDrive = sender.toggleState
            break
        case 1:
            //No Action
            Data.currentMatch?.teleopNoAction = sender.toggleState
            break
        case 2:
            //Broken Down
            Data.currentMatch?.teleopBrokeDown = sender.toggleState
            break
        default:
            //wat
            break
        }
    }
    
    @IBAction func SFButtonPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SFDialogViewController") as! SFDialogViewController
        vc.parentValue = sender.tag
        vc.period = "Teleop"
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func decrementButtonPressed(_ sender: UIButton) {
        switch(sender.tag) {
        case 0:
            //Shots Blocked
            Data.currentMatch?.teleopShotsBlocked -= 1
            break
        default:
            //wat
            break
        }
        reloadData()
    }
    
    @IBAction func incrementButtonPressed(_ sender: UIButton) {
        switch(sender.tag) {
        case 0:
            //Shots Blocked
            Data.currentMatch?.teleopShotsBlocked += 1
            break
        default:
            //wat
            break
        }
        reloadData()
    }
    
    func reloadData() {
        self.driveButton.toggle(toggleState: Data.currentMatch!.teleopDrive)
        self.noActionButton.toggle(toggleState: Data.currentMatch!.teleopNoAction)
        self.brokeDownButton.toggle(toggleState: Data.currentMatch!.teleopBrokeDown)
        self.shotsBlocked.text = String(describing: Data.currentMatch!.teleopShotsBlocked)
        self.lowGoalSuccess.text = "S: " + String(describing: Data.currentMatch!.teleopLowGoalSuccess)
        self.lowGoalFailure.text = "F: " + String(describing: Data.currentMatch!.teleopLowGoalFailure)
        self.highGoalSuccess.text = "S: " + String(describing: Data.currentMatch!.teleopHighGoalSuccess)
        self.highGoalFailure.text = "F: " + String(describing: Data.currentMatch!.teleopHighGoalFailure)
        self.lowBarSuccess.text = "S: " + String(describing: Data.currentMatch!.teleopLowBarSuccess)
        self.lowBarFailure.text = "F: " + String(describing: Data.currentMatch!.teleopLowBarFailure)
        self.def1Success.text = "S: " + String(describing: Data.currentMatch!.teleopDef1Success)
        self.def1Failure.text = "F: " + String(describing: Data.currentMatch!.teleopDef1Failure)
        self.def2Success.text = "S: " + String(describing: Data.currentMatch!.teleopDef2Success)
        self.def2Failure.text = "F: " + String(describing: Data.currentMatch!.teleopDef2Failure)
        self.def3Success.text = "S: " + String(describing: Data.currentMatch!.teleopDef3Success)
        self.def3Failure.text = "F: " + String(describing: Data.currentMatch!.teleopDef3Failure)
        self.def4Success.text = "S: " + String(describing: Data.currentMatch!.teleopDef4Success)
        self.def4Failure.text = "F: " + String(describing: Data.currentMatch!.teleopDef4Failure)
    }
}
