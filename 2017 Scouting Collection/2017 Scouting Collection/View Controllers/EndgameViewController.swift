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
        return numberOfChars < 150;
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        if(DataModel.data["auto_baseline"] == nil) {
            DataModel.data["auto_baseline"] = 0
        }
        if(DataModel.data["auto_no_action"] == nil) {
            DataModel.data["auto_no_action"] = 0
        }
        if(DataModel.data["auto_broke_down"] == nil) {
            DataModel.data["auto_broke_down"] = 0
        }
        if(DataModel.data["tele_no_action"] == nil) {
            DataModel.data["tele_no_action"] = 0
        }
        if(DataModel.data["tele_broke_down"] == nil) {
            DataModel.data["tele_broke_down"] = 0
        }
        DataModel.data["no_show"] = Int(NSNumber(value: matchAbandoned.isOn))
        DataModel.data["takeoff"] = takeoff.selectedSegmentIndex
        if(takeoff.selectedSegmentIndex == 2) {
            DataModel.data["takeoff_speed"] = Int(takeoffSpeed.value)
        } else {
            DataModel.data["takeoff_speed"] = -1
        }
        DataModel.data["defense"] = Int(NSNumber(value: defenseSwitch.isOn))
        if(defenseSwitch.isOn) {
            DataModel.data["defense_rating"] = Int(defenseRating.value)
        } else {
            DataModel.data["defense_rating"] = -1
        }
        DataModel.data["gear_ground_intake"] = Int(NSNumber(value: gearGroundIntakeSwitch.isOn))
        if(gearGroundIntakeSwitch.isOn) {
            DataModel.data["gear_ground_intake_rating"] = Int(gearGroundIntakeRating.value)
        } else {
            DataModel.data["gear_ground_intake_rating"] = -1
        }
        DataModel.data["fuel_ground_intake"] = Int(NSNumber(value: fuelGroundIntakeSwitch.isOn))
        if(fuelGroundIntakeSwitch.isOn) {
            DataModel.data["fuel_ground_intake_rating"] = Int(fuelGroundIntakeRating.value)
        } else {
            DataModel.data["fuel_ground_intake_rating"] = -1
        }
        DataModel.data["notes"] = additionalNotesTextView.text
        self.performSegue(withIdentifier: "endgameToQR", sender: nil)
    }
}
