//
//  AutoViewController.swift
//  2017 Scouting Collection
//
//  Created by Alex Tarng on 12/24/16.
//  Copyright © 2016 Paly Robotics. All rights reserved.
//

import Foundation
import UIKit
import Spring

class AutoViewController: ViewController {
    
    @IBOutlet weak var currentPeriod: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var endMatchButton: UIButton!
    @IBOutlet weak var scoutingTeamNumber: UILabel!
    
    
    var active : Int = 3
    
    @IBOutlet var contentViews: [SpringView]!
    
    
    @IBOutlet weak var gearButton: UIImageView!
    
    @IBOutlet var pegPosition: [UIButton]!
    @IBOutlet weak var placedGearButton: SpringView!
    @IBOutlet weak var totalGearsPlacedLabel: UILabel!
    @IBOutlet weak var droppedGearButton: UIView!
    @IBOutlet weak var droppedGearLabel: UILabel!
    
    
    @IBOutlet weak var pressureButton: UIButton!
    
    @IBOutlet weak var insideKeyButton: UIButton!
    @IBOutlet weak var outsideKeyButton: UIButton!
    @IBOutlet weak var highGoalsScoredButton: UIView!
    @IBOutlet weak var totalHighGoalsScoredLabel: UILabel!
    @IBOutlet weak var highGoalsMissedButton: UIView!
    @IBOutlet weak var totalHighGoalsMissedButton: UILabel!
    @IBOutlet weak var lowGoalDumpButton: UIView!
    @IBOutlet weak var totalLowGoalDumps: UILabel!
    
    
    @IBOutlet weak var fuelButton: UIImageView!

    @IBOutlet weak var fromHopperButton: UIView!
    @IBOutlet weak var totalFromHopperCollected: UILabel!
    @IBOutlet weak var totalFromAllainceStation: UILabel!
    @IBOutlet var fromAllainceStationButton: UIView!
    
    @IBOutlet weak var otherButton: UIButton!
    @IBOutlet weak var otherView: SpringView!
    @IBOutlet var otherOptions: [UIButton]!
    
    @IBOutlet weak var otherConstraintOne: NSLayoutConstraint!
    @IBOutlet weak var otherConstraintTwo: NSLayoutConstraint!
    
    @IBOutlet var redoButton: SpringButton!
    
    
    
    var timeLeftTimer: Timer!
    var timePassed : Int = 0
    var isAuto = true
    
    override func viewDidLoad() {
        timeLeftTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeLabel), userInfo: nil, repeats: true)
        
    }
    func updateTimeLabel() {
        timePassed += 1
        if timePassed > 20{
            isAuto = false
            currentPeriod.text = "Teleop"
        }
        if isAuto{
            timerLabel.text = "\(timePassed)"
        }else{
            let rawSeconds =  timePassed - 20
            let minutes = floor(Double(rawSeconds / 60))
            let seconds = Double(rawSeconds)  - (minutes * 60)
            if seconds > 10{
                timerLabel.text = "\(Int(minutes)):\(Int(seconds))"
            }else{
                timerLabel.text = "\(Int(minutes)):0\(Int(seconds))"
            }
            
        }
        
        
    }
    func hideSelectedContentView(){
        if active == 3{
            for contentView in contentViews{
                contentView.isHidden = true
            }
            return
        }
        contentViews[active].animation = "fadeOut"
        contentViews[active].curve = "easeIn"
        contentViews[active].duration = 1.0
        contentViews[active].animate()
        contentViews[active].isHidden = true
    }
    func showSelectedContentView(){
        
        contentViews[active].animation = "fadeIn"
        contentViews[active].curve = "easeIn"
        contentViews[active].duration = 1.0
        contentViews[active].animate()
        contentViews[active].isHidden = false
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scoutingTeamNumber.text = "Team \(DataModel.scoutingTeamNumber)"
        
        //Insets for the images
        let insets = UIEdgeInsets(top: 25, left: 0, bottom: 25, right: 0)
        
        let gearImage = UIImage(named: "gears")!
        gearButton.image = gearImage.imageWithInsets(insets: insets)
        
        let fuelImage = UIImage(named: "fuel-intake")
        fuelButton.image = fuelImage?.imageWithInsets(insets: insets)
        
        //Tap recognizers for imageView
        let gearTap = UITapGestureRecognizer(target: self, action: #selector(gearButtonTapped))
        gearButton.addGestureRecognizer(gearTap)
        gearButton.isUserInteractionEnabled = true
        
        let fuelTap = UITapGestureRecognizer(target: self, action: #selector(fuelButtonTapped))
        fuelButton.addGestureRecognizer(fuelTap)
        fuelButton.isUserInteractionEnabled = true
        
        hideSelectedContentView()
        
        //Adding tap recognizers for gear place/drop views
        let placedGearTap = UITapGestureRecognizer(target: self, action: #selector(placedGearButtonPressed))
        placedGearButton.addGestureRecognizer(placedGearTap)
        
        let droppedGearTap = UITapGestureRecognizer(target: self, action: #selector(droppedGearButtonPressed))
        droppedGearButton.addGestureRecognizer(droppedGearTap)
        droppedGearButton.isUserInteractionEnabled = true
        
        //Adding the tap recognizers for the high goal make/miss and low goal dumps.
        let highGoalScoredTap = UITapGestureRecognizer(target: self, action: #selector(highGoalsScoredPressed))
        highGoalsScoredButton.addGestureRecognizer(highGoalScoredTap)
        let highGoalMissedTap = UITapGestureRecognizer(target: self, action: #selector(highGoalsMissedPressed))
        highGoalsMissedButton.addGestureRecognizer(highGoalMissedTap)
        let lowGoalDumpTap = UITapGestureRecognizer(target: self, action: #selector(lowGoalDumpedPressed))
        lowGoalDumpButton.addGestureRecognizer(lowGoalDumpTap)
        lowGoalDumpButton.isUserInteractionEnabled = true
        
        //Adding the gesture recognizers for the fuel buttons
        let fromHopperTap = UITapGestureRecognizer(target: self, action: #selector(fromHopperPressed))
        fromHopperButton.addGestureRecognizer(fromHopperTap)
        fromHopperButton.isUserInteractionEnabled = true
        
        let fromAllainceStationTap = UITapGestureRecognizer(target: self, action: #selector(fromAllainceStationPressed))
        fromAllainceStationButton.addGestureRecognizer(fromAllainceStationTap)
        fromAllainceStationButton.isUserInteractionEnabled = true
        
        redoButton.isHidden = true
        
        
//        gearButton.backgroundColor = UIColor(colorLiteralRed: 60/255, green: 110/255, blue: 113/255, alpha: 1)
        
    }
    
    func gearButtonTapped(){
        hideSelectedContentView()
        active = 0
        showSelectedContentView()
        
        for senderX in pegPosition{
            senderX.backgroundColor = UIColor(colorLiteralRed: 60/255, green: 110/255, blue: 113/255, alpha: 1)
            senderX.layer.borderWidth = 0
            senderX.setTitleColor(UIColor.white, for: UIControlState.normal)
        }

        placedGearButton.isUserInteractionEnabled = false
        placedGearButton.layer.opacity = 0.5

        
    }
    
    @IBAction func pegButtonPressed(_ sender: UIButton) {
        
        if sender.backgroundColor == UIColor.white{
            
            sender.backgroundColor = UIColor(colorLiteralRed: 60/255, green: 110/255, blue: 113/255, alpha: 1)
            sender.layer.borderWidth = 0
            sender.setTitleColor(UIColor.white, for: UIControlState.normal)
            
            placedGearButton.isUserInteractionEnabled = false
            placedGearButton.layer.opacity = 0.5
            
        }else{
            for button in pegPosition{
                button.backgroundColor = UIColor(colorLiteralRed: 60/255, green: 110/255, blue: 113/255, alpha: 1)
                button.layer.borderWidth = 0
                button.titleLabel!.textColor = UIColor.white
            }
            
            sender.backgroundColor = UIColor.white
            sender.layer.borderWidth = 1
            sender.layer.borderColor = UIColor(colorLiteralRed: 60/255, green: 110/255, blue: 113/255, alpha: 1).cgColor
            
            sender.setTitleColor(UIColor(colorLiteralRed: 60/255, green: 110/255, blue: 113/255, alpha: 1), for: UIControlState.normal)
            
            placedGearButton.isUserInteractionEnabled = true
            placedGearButton.layer.opacity = 1
            
        }
        
    }

    
    func placedGearButtonPressed(){
        UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.placedGearButton.alpha = 0.5
            
        }) { (done) in
            if done{
                self.placedGearButton.alpha = 1.0
            }
        }
        
        
        var currentPegPosition = "";
        for selectedButton : UIButton in pegPosition{
            if selectedButton.backgroundColor == UIColor.white{
                currentPegPosition = selectedButton.titleLabel!.text!
            }
        }
        
        let action = Action(time: timePassed, action: Action.RobotAction.GearPlaced)
        switch currentPegPosition {
        case "Key Peg":
            action.gearPlaced(pegPosition: Action.Pegs.Key)
            break
        case "Middle Peg":
            action.gearPlaced(pegPosition: Action.Pegs.Middle)
            break
        case "Loading Peg":
            action.gearPlaced(pegPosition: Action.Pegs.Loading)
            break
        default:
            break
        }
        DataModel.printData()
        
        updateLabels()
        
    }
    
    func droppedGearButtonPressed(){
        UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.droppedGearButton.alpha = 0.5
            
        }) { (done) in
            if done{
                self.droppedGearButton.alpha = 1.0
            }
        }
        let action = Action(time: timePassed, action: Action.RobotAction.GearDropped)
        print("gearDropped")
        updateLabels()
    }
    
    @IBAction func pressureButtonTapped(_ sender: Any) {
        hideSelectedContentView()
        active = 1
        showSelectedContentView()
        
        insideKeyButton.backgroundColor = UIColor(colorLiteralRed: 60/255, green: 110/255, blue: 113/255, alpha: 1)
        insideKeyButton.layer.borderWidth = 0
        insideKeyButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        outsideKeyButton.backgroundColor = UIColor(colorLiteralRed: 60/255, green: 110/255, blue: 113/255, alpha: 1)
        outsideKeyButton.layer.borderWidth = 0
        outsideKeyButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        highGoalsScoredButton.isUserInteractionEnabled = false
        highGoalsMissedButton.isUserInteractionEnabled = false
        highGoalsScoredButton.layer.opacity = 0.5
        highGoalsMissedButton.layer.opacity = 0.5

    }
    
    @IBAction func keyPositionButtonPressed(_ sender: UIButton) {
        print("pressedKeyPos")
        if sender.backgroundColor == UIColor.white{
            
            sender.backgroundColor = UIColor(colorLiteralRed: 60/255, green: 110/255, blue: 113/255, alpha: 1)
            sender.layer.borderWidth = 0
            sender.setTitleColor(UIColor.white, for: UIControlState.normal)
            
            highGoalsScoredButton.isUserInteractionEnabled = false
            highGoalsMissedButton.isUserInteractionEnabled = false
            highGoalsScoredButton.layer.opacity = 0.5
            highGoalsMissedButton.layer.opacity = 0.5
        }else{
            for button : UIButton in [insideKeyButton, outsideKeyButton]{
                button.backgroundColor = UIColor(colorLiteralRed: 60/255, green: 110/255, blue: 113/255, alpha: 1)
                button.layer.borderWidth = 0
                button.titleLabel!.textColor = UIColor.white
            }
            
            sender.backgroundColor = UIColor.white
            sender.layer.borderWidth = 1
            sender.layer.borderColor = UIColor(colorLiteralRed: 60/255, green: 110/255, blue: 113/255, alpha: 1).cgColor
            
            sender.setTitleColor(UIColor(colorLiteralRed: 60/255, green: 110/255, blue: 113/255, alpha: 1), for: UIControlState.normal)
            
            
            highGoalsScoredButton.isUserInteractionEnabled = true
            highGoalsMissedButton.isUserInteractionEnabled = true
            highGoalsScoredButton.layer.opacity = 1
            highGoalsMissedButton.layer.opacity = 1
            
        }
    }

    
    
    func highGoalsScoredPressed(){
        UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.highGoalsScoredButton.alpha = 0.5
            
        }) { (done) in
            if done{
                self.highGoalsScoredButton.alpha = 1.0
            }
        }
        print("highGoalScored")
        var currentPosition = ""
        for selectedButton : UIButton in [insideKeyButton, outsideKeyButton]{
            if selectedButton.backgroundColor == UIColor.white{
                currentPosition = selectedButton.titleLabel!.text!
            }
        }
        
        let action = Action(time: timePassed, action: Action.RobotAction.HighGoal)
        
        switch currentPosition {
        case "Inside Key":
            action.highGoal(successful: true, shootingPosition: Action.ShootingPosition.InsideKey)
            break
        case "Outside Key":
            action.highGoal(successful: true, shootingPosition: Action.ShootingPosition.OutsideKey)
            break
        default:
            break
        }
        updateLabels()
        
    }
    
    func highGoalsMissedPressed(){
        UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.highGoalsMissedButton.alpha = 0.5
            
        }) { (done) in
            if done{
                self.highGoalsMissedButton.alpha = 1.0
            }
        }
        print("highGoalMissed")
        var currentPosition = ""
        for selectedButton : UIButton in [insideKeyButton, outsideKeyButton]{
            if selectedButton.backgroundColor == UIColor.white{
                currentPosition = selectedButton.titleLabel!.text!
            }
        }
        
        let action = Action(time: timePassed, action: Action.RobotAction.HighGoal)
        
        switch currentPosition {
        case "Inside Key":
            action.highGoal(successful: false, shootingPosition: Action.ShootingPosition.InsideKey)
            break
        case "Outside Key":
            action.highGoal(successful: false, shootingPosition: Action.ShootingPosition.OutsideKey)
            break
        default:
            break
        }
        updateLabels()
    }
    
    func lowGoalDumpedPressed(){
        UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.lowGoalDumpButton.alpha = 0.5
            
        }) { (done) in
            if done{
                self.lowGoalDumpButton.alpha = 1.0
            }
        }
        print("lowGoal")
        let action = Action(time: timePassed, action: Action.RobotAction.LowGoal)
        updateLabels()
    }
    
    
    func fuelButtonTapped(){
        hideSelectedContentView()
        active = 2
        showSelectedContentView()
    }
    
    func fromHopperPressed(){
        UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.fromHopperButton.alpha = 0.5
            
        }) { (done) in
            if done{
                self.fromHopperButton.alpha = 1.0
            }
        }
        print("hopper")
        let action = Action(time: timePassed, action: Action.RobotAction.FuelRetrieved)
        action.fuelRetrieved(source: Action.FuelRetrievalPositions.Hopper)
        updateLabels()
        
    }
    
    func fromAllainceStationPressed(){
        
        UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.fromAllainceStationButton.alpha = 0.5
            
        }) { (done) in
            if done{
                self.fromAllainceStationButton.alpha = 1.0
            }
        }
        print("allaince")
        let action = Action(time: timePassed, action: Action.RobotAction.FuelRetrieved)
        action.fuelRetrieved(source: Action.FuelRetrievalPositions.AllainceStation)
        DataModel.printData()
        updateLabels()
    }
    
    var otherViewShown = true
    
    @IBAction func dismissedButtonPressed(_ sender: UIButton) {
        if otherViewShown{
            otherView.animation = "fadeOut"
            otherView.curve = "easeIn"
            otherView.duration = 1.0
            otherView.animate()

            otherViewShown = false
            sender.setTitle("Other", for: .normal)
            return
        }
        otherView.animation = "slideRight"
        otherView.curve = "linear"
        otherView.duration = 1.0
        otherView.animate()
        otherViewShown = true
        sender.setTitle("Dismiss", for: .normal)
    }
    
    @IBAction func crossedBaselinePressed(_ sender: Any) {
        let action = Action(time: timePassed, action: Action.RobotAction.BaselineCrossed)
        otherConstraintOne.constant = 0
        otherConstraintTwo.constant = 0
        
    }
    @IBAction func noActionPressed(_ sender: Any) {
        let action = Action(time: timePassed, action: Action.RobotAction.NoAction)
        
    }
    @IBAction func brokeDownPressed(_ sender: Any) {
        let action = Action(time: timePassed, action: Action.RobotAction.BreakDown)
    }
    
    
    
    
    @IBAction func undoButtonPressed(_ sender: UIButton) {
        print("pressed")
        DataModel.undoAction()
        updateLabels()
        if !DataModel.undidActions.isEmpty && redoButton.isHidden{
            redoButton.isHidden = false
            redoButton.animation = "slideUp"
            redoButton.force = 0.1
            redoButton.animate()
        }
    }
    
    @IBAction func redoButtonPressed(_ sender: Any) {
        DataModel.redoAction()
        updateLabels()
        print(DataModel.undidActions)
        if DataModel.undidActions.isEmpty{
            redoButton.animation = "fadeOut"
            redoButton.animate()
            redoButton.isHidden = true
        }
    }
    
    
    func updateLabels(){
        print("updatingLabels")
        var totalGearsPlaced : Int = 0
        var totalGearsDropped : Int = 0
        var totalSuccessfulHighGoals : Int = 0
        var totalUnsuccessfulHighGoals : Int = 0
        var totalLowGoalDumps : Int = 0
        var totalFuelRetrievedFromAllainceStation : Int = 0
        var totalFuelRetrievedFromHoppers : Int = 0
        
        for actionX in DataModel.actions{
            print(actionX.action)
            switch actionX.action {
            case Action.RobotAction.GearPlaced:
                totalGearsPlaced += 1
                print("gears-placed")
                break
            case Action.RobotAction.GearDropped:
                totalGearsDropped += 1
                print("gears-dropped")
                break
            case Action.RobotAction.HighGoal:
                if actionX.highGoalSuccessful! == true{
                    totalSuccessfulHighGoals += 1
                }else{
                    totalUnsuccessfulHighGoals += 1
                }
                break
            case Action.RobotAction.LowGoal:
                totalLowGoalDumps += 1
                break
            case Action.RobotAction.FuelRetrieved:
                if actionX.fuelRetrievialSource == Action.FuelRetrievalPositions.AllainceStation{
                    totalFuelRetrievedFromAllainceStation += 1
                }else{
                    totalFuelRetrievedFromHoppers += 1
                }
                break
            default:
                break
            }
        }
        totalGearsPlacedLabel.text = "Placed: \(totalGearsPlaced)"
        droppedGearLabel.text = "Dropped: \(totalGearsDropped)"
        totalHighGoalsScoredLabel.text = "Scored: \(totalSuccessfulHighGoals)"
        totalHighGoalsMissedButton.text = "Missed: \(totalUnsuccessfulHighGoals)"
        self.totalLowGoalDumps.text = "Dumps: \(totalLowGoalDumps)"
        totalFromHopperCollected.text = "Total: \(totalFuelRetrievedFromHoppers)"
        totalFromAllainceStation.text = "Total: \(totalFuelRetrievedFromAllainceStation)"
        
    }
    
    @IBAction func endMatchButtonPressed(_ sender: Any) {
        if timePassed > 279{
            performSegue(withIdentifier: "endMatch", sender: self)
        }else{
            let alert = UIAlertController(title: "Match End Confirmation", message: "Are you sure you want to end match?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
                self.performSegue(withIdentifier: "endMatch", sender: self)

            }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
}
extension UIImage {
    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let _ = UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }
}
