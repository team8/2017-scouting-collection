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
    
    @IBOutlet weak var leftPegSuccess: UILabel!
    @IBOutlet weak var leftPegFailure: UILabel!
    @IBOutlet weak var centerPegSuccess: UILabel!
    @IBOutlet weak var centerPegFailure: UILabel!
    @IBOutlet weak var rightPegSuccess: UILabel!
    @IBOutlet weak var rightPegFailure: UILabel!
    
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
        self.leftPegSuccess.text = "S: " + String(describing: DataModel.currentMatch!.autoDef1Success)
        self.leftPegFailure.text = "F: " + String(describing: DataModel.currentMatch!.autoDef1Failure)
        self.centerPegSuccess.text = "S: " + String(describing: DataModel.currentMatch!.autoDef2Success)
        self.centerPegFailure.text = "F: " + String(describing: DataModel.currentMatch!.autoDef2Failure)
        self.rightPegSuccess.text = "S: " + String(describing: DataModel.currentMatch!.autoDef3Success)
        self.rightPegFailure.text = "F: " + String(describing: DataModel.currentMatch!.autoDef3Failure)
    }
}
