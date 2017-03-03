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
    @IBOutlet weak var gearPlacementRating: UISlider!
    @IBOutlet weak var gearPlacementLabel: UILabel!
    @IBOutlet weak var lowGoalShootingRating: UISlider!
    @IBOutlet weak var lowGoalShootingLabel: UILabel!
    @IBOutlet weak var highGoalShootingRating: UISlider!
    @IBOutlet weak var highGoalShootingLabel: UILabel!
    @IBOutlet weak var groundFuelIntake: UISwitch!
    @IBOutlet weak var additionalNotes: UITextView!
    @IBOutlet weak var additionalNotesPopUpView: UIView!
    @IBOutlet weak var additionalNotesTextView: UITextView!
    @IBOutlet weak var additionalNotesDoneButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    @IBAction func gearPlacementRatingChanged(_ sender: Any) {
        gearPlacementLabel.text = "\(Int(gearPlacementRating.value))/10"

    }
    @IBAction func lowGoalShootingChanged(_ sender: Any) {
        lowGoalShootingLabel.text = "\(Int(lowGoalShootingRating.value))/10"
        
    }
    @IBAction func highGoalShootingChanged(_ sender: Any) {
        highGoalShootingLabel.text = "\(Int(highGoalShootingRating.value))/10"
    }
    
    func additionalNotesTapped(){
        additionalNotesPopUpView.isHidden = false
        view.layer.backgroundColor = UIColor.gray.cgColor
        
        matchAbandoned.isUserInteractionEnabled = false
//        robotScaled.isUserInteractionEnabled = false
        gearPlacementRating.isUserInteractionEnabled = false
        lowGoalShootingRating.isUserInteractionEnabled = false
        highGoalShootingRating.isUserInteractionEnabled = false
        groundFuelIntake.isUserInteractionEnabled = false
        additionalNotes.isUserInteractionEnabled = false
        
        additionalNotesTextView.becomeFirstResponder()
        
    }
    @IBAction func doneAdditionalNotes(_ sender: Any) {
        view.endEditing(true)
        additionalNotesPopUpView.isHidden = true
        view.layer.backgroundColor = UIColor.white.cgColor
        
        matchAbandoned.isUserInteractionEnabled = true
//        robotScaled.isUserInteractionEnabled = true
        gearPlacementRating.isUserInteractionEnabled = true
        lowGoalShootingRating.isUserInteractionEnabled = true
        highGoalShootingRating.isUserInteractionEnabled = true
        groundFuelIntake.isUserInteractionEnabled = true
        additionalNotes.isUserInteractionEnabled = true
        
        additionalNotes.text = additionalNotesTextView.text
        additionalNotes.font = UIFont(name: "Lato-Light", size: 19.0)!
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.characters.count
        return numberOfChars < 150;
    }
    
}
