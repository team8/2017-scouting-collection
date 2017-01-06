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
    
    @IBOutlet weak var driveButton: ToggleButton!
    @IBOutlet weak var noActionButton: ToggleButton!
    @IBOutlet weak var brokeDownButton: ToggleButton!
    @IBOutlet weak var collisionButton: ToggleButton!
    @IBOutlet weak var reachButton: ToggleButton!
    
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
                DataModel.currentMatch?.autoDrive = sender.toggleState
                break
            case 1:
                //No Action
                DataModel.currentMatch?.autoNoAction = sender.toggleState
                break
            case 2:
                //Broken Down
                DataModel.currentMatch?.autoBrokeDown = sender.toggleState
                break
            case 3:
                //Collision
                DataModel.currentMatch?.autoCollision = sender.toggleState
                break
            case 4:
                //Reach
                DataModel.currentMatch?.autoReach = sender.toggleState
                break
            default:
                //wat
                break
        }
    }
    
    @IBAction func SFButtonPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SFDialogViewController") as! SFDialogViewController
        vc.parentValue = sender.tag
        vc.period = "Autonomous"
        self.present(vc, animated: false, completion: nil)
    }
    
    func reloadData() {
        self.driveButton.toggle(toggleState: DataModel.currentMatch!.autoDrive)
        self.noActionButton.toggle(toggleState: DataModel.currentMatch!.autoNoAction)
        self.brokeDownButton.toggle(toggleState: DataModel.currentMatch!.autoBrokeDown)
        self.collisionButton.toggle(toggleState: DataModel.currentMatch!.autoCollision)
        self.reachButton.toggle(toggleState: DataModel.currentMatch!.autoReach)
        self.lowGoalSuccess.text = "S: " + String(describing: DataModel.currentMatch!.autoLowGoalSuccess)
        self.lowGoalFailure.text = "F: " + String(describing: DataModel.currentMatch!.autoLowGoalFailure)
        self.highGoalSuccess.text = "S: " + String(describing: DataModel.currentMatch!.autoHighGoalSuccess)
        self.highGoalFailure.text = "F: " + String(describing: DataModel.currentMatch!.autoHighGoalFailure)
        self.lowBarSuccess.text = "S: " + String(describing: DataModel.currentMatch!.autoLowBarSuccess)
        self.lowBarFailure.text = "F: " + String(describing: DataModel.currentMatch!.autoLowBarFailure)
        self.def1Success.text = "S: " + String(describing: DataModel.currentMatch!.autoDef1Success)
        self.def1Failure.text = "F: " + String(describing: DataModel.currentMatch!.autoDef1Failure)
        self.def2Success.text = "S: " + String(describing: DataModel.currentMatch!.autoDef2Success)
        self.def2Failure.text = "F: " + String(describing: DataModel.currentMatch!.autoDef2Failure)
        self.def3Success.text = "S: " + String(describing: DataModel.currentMatch!.autoDef3Success)
        self.def3Failure.text = "F: " + String(describing: DataModel.currentMatch!.autoDef3Failure)
        self.def4Success.text = "S: " + String(describing: DataModel.currentMatch!.autoDef4Success)
        self.def4Failure.text = "F: " + String(describing: DataModel.currentMatch!.autoDef4Failure)
    }
}
