//
//  EndgameViewController.swift
//  2017 Scouting Collection
//
//  Created by Alex Tarng on 12/24/16.
//  Copyright © 2016 Paly Robotics. All rights reserved.
//

import Foundation
import UIKit


class EndgameViewController: ViewController, UITextViewDelegate{
    
    @IBOutlet weak var matchAbandoned: UISwitch!
//    @IBOutlet weak var robotScaled: UISwitch!
    @IBOutlet weak var takeoff: UISegmentedControl!
    @IBOutlet weak var takeoffSpeed: UISlider!
    @IBOutlet weak var takeoffLabel: UILabel!
    @IBOutlet weak var defenseSwitch: UISwitch!
    @IBOutlet weak var defenseRating: UISlider!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var gearGroundIntakeSwitch: UISwitch!
    @IBOutlet weak var gearGroundIntakeRating: UISlider!
    @IBOutlet weak var gearGroundIntakeLabel: UILabel!
    @IBOutlet weak var fuelGroundIntakeSwitch: UISwitch!
    @IBOutlet weak var fuelGroundIntakeRating: UISlider!
    @IBOutlet weak var fuelGroundIntakeLabel: UILabel!
    @IBOutlet weak var driverSkillRating: UISlider!
    @IBOutlet weak var driverSkillRatingLabel: UILabel!
    @IBOutlet weak var additionalNotes: UITextView!
    @IBOutlet weak var additionalNotesPopUpView: UIView!
    @IBOutlet weak var additionalNotesTextView: UITextView!
    @IBOutlet weak var additionalNotesDoneButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        takeoffSpeed.isEnabled = false
        defenseRating.isEnabled = false
        gearGroundIntakeRating.isEnabled = false
        fuelGroundIntakeRating.isEnabled = false
        
        let additionalNotesTap = UITapGestureRecognizer(target: self, action: #selector(additionalNotesTapped))
        additionalNotes.addGestureRecognizer(additionalNotesTap)
        additionalNotes.isUserInteractionEnabled = true
        additionalNotes.layer.borderColor = UIColor.gray.cgColor
        additionalNotes.layer.borderWidth = 1
        additionalNotes.layer.cornerRadius = 5
        additionalNotes.layer.masksToBounds = true
        
        
        additionalNotesPopUpView.isHidden = true
        
        additionalNotesTextView.layer.borderColor = UIColor.gray.cgColor
        additionalNotesTextView.layer.borderWidth = 1
        additionalNotesTextView.layer.cornerRadius = 5
        additionalNotesTextView.layer.masksToBounds = true
        
        additionalNotesDoneButton.layer.cornerRadius = 5
        additionalNotesDoneButton.layer.masksToBounds = true

    }
    @IBAction func takeoffChanged(_ sender: Any) {
        if(takeoff.selectedSegmentIndex == 2) {
            takeoffSpeed.isEnabled = true
        } else {
            takeoffSpeed.isEnabled = false
        }
    }
    @IBAction func takeoffSpeedChanged(_ sender: Any) {
        takeoffLabel.text = "\(Int(takeoffSpeed.value))/5"
    }
    @IBAction func defenseSwitchChanged(_ sender: Any) {
        if(defenseSwitch.isOn) {
            defenseRating.isEnabled = true
        } else {
            defenseRating.isEnabled = false
        }
    }
    @IBAction func defenseRatingChanged(_ sender: Any) {
        defenseLabel.text = "\(Int(defenseRating.value))/5"

    }
    @IBAction func gearGroundIntakeSwitchChanged(_ sender: Any) {
        if(gearGroundIntakeSwitch.isOn) {
            gearGroundIntakeRating.isEnabled = true
        } else {
            gearGroundIntakeRating.isEnabled = false
        }
    }
    @IBAction func gearGroundIntakeChanged(_ sender: Any) {
        gearGroundIntakeLabel.text = "\(Int(gearGroundIntakeRating.value))/5"
        
    }
    @IBAction func fuelGroundIntakeSwitchChanged(_ sender: Any) {
        if(fuelGroundIntakeSwitch.isOn) {
            fuelGroundIntakeRating.isEnabled = true
        } else {
            fuelGroundIntakeRating.isEnabled = false
        }
    }
    @IBAction func fuelGroundIntakeChanged(_ sender: Any) {
        fuelGroundIntakeLabel.text = "\(Int(fuelGroundIntakeRating.value))/5"
    }
    @IBAction func driverSkillRatingChanged(_ sender: Any) {
        driverSkillRatingLabel.text = "\(Int(driverSkillRating.value))/5"
    }
    
    func additionalNotesTapped(){
        additionalNotesPopUpView.isHidden = false
        view.layer.backgroundColor = UIColor.gray.cgColor
        
        matchAbandoned.isUserInteractionEnabled = false
        takeoff.isUserInteractionEnabled = false
        takeoffSpeed.isUserInteractionEnabled = false
        defenseSwitch.isUserInteractionEnabled = false
        defenseRating.isUserInteractionEnabled = false
        gearGroundIntakeSwitch.isUserInteractionEnabled = false
        gearGroundIntakeRating.isUserInteractionEnabled = false
        fuelGroundIntakeSwitch.isUserInteractionEnabled = false
        fuelGroundIntakeRating.isUserInteractionEnabled = false
        additionalNotes.isUserInteractionEnabled = false
        
        additionalNotesTextView.becomeFirstResponder()
        
    }
    @IBAction func doneAdditionalNotes(_ sender: Any) {
        view.endEditing(true)
        additionalNotesPopUpView.isHidden = true
        view.layer.backgroundColor = UIColor.white.cgColor
        
        matchAbandoned.isUserInteractionEnabled = true
        takeoff.isUserInteractionEnabled = true
        takeoffSpeed.isUserInteractionEnabled = true
        defenseSwitch.isUserInteractionEnabled = true
        defenseRating.isUserInteractionEnabled = true
        gearGroundIntakeSwitch.isUserInteractionEnabled = true
        gearGroundIntakeRating.isUserInteractionEnabled = true
        fuelGroundIntakeSwitch.isUserInteractionEnabled = true
        fuelGroundIntakeRating.isUserInteractionEnabled = true
        additionalNotes.isUserInteractionEnabled = true
        
        additionalNotes.text = additionalNotesTextView.text
        additionalNotes.font = UIFont(name: "Lato-Light", size: 19.0)!
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.characters.count
        return numberOfChars < 250;
    }
    
    @IBAction func backPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Go Back Confirmation", message: "Are you sure you want to go back to teleop? This will erase all data inputted on this page.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
            self.performSegue(withIdentifier: "unwindEndgameToAuto", sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func submitPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Submit Confirmation", message: "Are you sure you want to submit?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
            if(DataModel.currentData!.data["auto_baseline"] == nil) {
                DataModel.currentData!.data["auto_baseline"] = 0
            }
            if(DataModel.currentData!.data["auto_no_action"] == nil) {
                DataModel.currentData!.data["auto_no_action"] = 0
            }
            if(DataModel.currentData!.data["auto_broke_down"] == nil) {
                DataModel.currentData!.data["auto_broke_down"] = 0
            }
            if(DataModel.currentData!.data["tele_no_action"] == nil) {
                DataModel.currentData!.data["tele_no_action"] = 0
            }
            if(DataModel.currentData!.data["tele_broke_down"] == nil) {
                DataModel.currentData!.data["tele_broke_down"] = 0
            }
            DataModel.currentData!.data["no_show"] = Int(NSNumber(value: self.matchAbandoned.isOn))
            DataModel.currentData!.data["takeoff"] = self.takeoff.selectedSegmentIndex
            if(self.takeoff.selectedSegmentIndex == 2) {
                DataModel.currentData!.data["takeoff_speed"] = Int(self.takeoffSpeed.value)
            } else {
                DataModel.currentData!.data["takeoff_speed"] = -1
            }
            DataModel.currentData!.data["defense"] = Int(NSNumber(value: self.defenseSwitch.isOn))
            if(self.defenseSwitch.isOn) {
                DataModel.currentData!.data["defense_rating"] = Int(self.defenseRating.value)
            } else {
                DataModel.currentData!.data["defense_rating"] = -1
            }
            DataModel.currentData!.data["gear_ground_intake"] = Int(NSNumber(value: self.gearGroundIntakeSwitch.isOn))
            if(self.gearGroundIntakeSwitch.isOn) {
                DataModel.currentData!.data["gear_ground_intake_rating"] = Int(self.gearGroundIntakeRating.value)
            } else {
                DataModel.currentData!.data["gear_ground_intake_rating"] = -1
            }
            DataModel.currentData!.data["fuel_ground_intake"] = Int(NSNumber(value: self.fuelGroundIntakeSwitch.isOn))
            if(self.fuelGroundIntakeSwitch.isOn) {
                DataModel.currentData!.data["fuel_ground_intake_rating"] = Int(self.fuelGroundIntakeRating.value)
            } else {
                DataModel.currentData!.data["fuel_ground_intake_rating"] = -1
            }
            DataModel.currentData!.data["driver_skill_rating"] = Int(self.driverSkillRating.value)
            DataModel.currentData!.data["notes"] = self.additionalNotesTextView.text
            
//            DataModel.storedCSVs.append(DataModel.currentData!.CSV())
//            DataModel.saveCSVsToCoreData()
            DataModel.currentData!.compile()
            DataModel.removeDuplicate(DataModel.currentData!)
//            print(DataModel.dataList)
            DataModel.dataList.append(DataModel.currentData!)
            print(DataModel.dataList.count)
            DataModel.saveDataToCoreData()
            
            self.performSegue(withIdentifier: "endgameToQR", sender: DataModel.currentData!)
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "endgameToQR") {
            let secondViewController = segue.destination as! QRCodeViewController
            let data = sender as! DataModel
            secondViewController.data = data
        }
    }
}
