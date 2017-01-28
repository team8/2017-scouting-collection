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
    
    @IBOutlet weak var lpSuccess: UILabel!
    @IBOutlet weak var lpFailure: UILabel!
    @IBOutlet weak var cpSuccess: UILabel!
    @IBOutlet weak var cpFailure: UILabel!
    @IBOutlet weak var rpSuccess: UILabel!
    @IBOutlet weak var rpFailure: UILabel!
    
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
            DataModel.currentMatch?.teleopDrive = sender.toggleState
            break
        case 1:
            //No Action
            DataModel.currentMatch?.teleopNoAction = sender.toggleState
            break
        case 2:
            //Broken Down
            DataModel.currentMatch?.teleopBrokeDown = sender.toggleState
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
            DataModel.currentMatch?.teleopShotsBlocked -= 1
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
            DataModel.currentMatch?.teleopShotsBlocked += 1
            break
        default:
            //wat
            break
        }
        reloadData()
    }
    
    func reloadData() {
        self.driveButton.toggle(toggleState: DataModel.currentMatch!.teleopDrive)
        self.noActionButton.toggle(toggleState: DataModel.currentMatch!.teleopNoAction)
        self.brokeDownButton.toggle(toggleState: DataModel.currentMatch!.teleopBrokeDown)
        self.shotsBlocked.text = String(describing: DataModel.currentMatch!.teleopShotsBlocked)
        self.lowGoalSuccess.text = "S: " + String(describing: DataModel.currentMatch!.teleopLowGoalSuccess)
        self.lowGoalFailure.text = "F: " + String(describing: DataModel.currentMatch!.teleopLowGoalFailure)
        self.highGoalSuccess.text = "S: " + String(describing: DataModel.currentMatch!.teleopHighGoalSuccess)
        self.highGoalFailure.text = "F: " + String(describing: DataModel.currentMatch!.teleopHighGoalFailure)
        self.lpSuccess.text = "S: " + String(describing: DataModel.currentMatch!.teleopDef1Success)
        self.lpFailure.text = "F: " + String(describing: DataModel.currentMatch!.teleopDef1Failure)
        self.cpSuccess.text = "S: " + String(describing: DataModel.currentMatch!.teleopDef2Success)
        self.cpFailure.text = "F: " + String(describing: DataModel.currentMatch!.teleopDef2Failure)
        self.rpSuccess.text = "S: " + String(describing: DataModel.currentMatch!.teleopDef3Success)
        self.rpFailure.text = "F: " + String(describing: DataModel.currentMatch!.teleopDef3Failure)
    }
}
