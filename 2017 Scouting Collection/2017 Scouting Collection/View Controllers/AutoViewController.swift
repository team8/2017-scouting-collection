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
    @IBOutlet weak var halfLowGoalButton: UIView!
    @IBOutlet weak var totalHalfLowGoal: UILabel!
    @IBOutlet weak var totalHighGoals: UILabel!
    @IBOutlet weak var totalLowGoals: UILabel!
    
    @IBOutlet weak var fuelButton: UIImageView!

    @IBOutlet weak var fuelFromHopperButton: UIView!
    @IBOutlet weak var totalFuelFromHopperCollected: UILabel!
    @IBOutlet weak var totalFuelFromLoadingStation: UILabel!
    @IBOutlet var fuelFromLoadingStationButton: UIView!
    
    @IBOutlet weak var gearsGroundIntakeButton: UIView!
    @IBOutlet weak var gearsFromLoadingStationButton: UIView!
    @IBOutlet weak var gearsDroppedAtLoadingStationButton: UIView!
    @IBOutlet weak var totalGearsGroundIntake: UILabel!
    @IBOutlet weak var totalGearsFromLoadingStation: UILabel!
    @IBOutlet weak var totalGearsDroppedAtLoadingStation: UILabel!
    
    @IBOutlet weak var otherButton: UIButton!
    @IBOutlet weak var otherView: SpringView!
    @IBOutlet var otherOptions: [UIButton]!
    
    @IBOutlet weak var baselineButton: UIButton!
    @IBOutlet weak var noActionButton: UIButton!
    @IBOutlet weak var brokeDownButton: UIButton!
    
    @IBOutlet weak var droppedGearHeight: NSLayoutConstraint!
    @IBOutlet weak var gearFailedLabel: UILabel!
    @IBOutlet weak var boilerPegButton: UIButton!
    @IBOutlet weak var middlePegButton: UIButton!
    @IBOutlet weak var loadingPegButton: UIButton!
    
    @IBOutlet weak var gearFailedCount: UILabel!
    
    
    @IBOutlet weak var otherConstraintOne: NSLayoutConstraint!
    @IBOutlet weak var otherConstraintTwo: NSLayoutConstraint!
    
    @IBOutlet var redoButton: SpringButton!
    
    
    
    var timeLeftTimer: Timer!
    var timePassed : Float = 0
    var isAuto = true
    
    override func viewDidLoad() {
        timeLeftTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimeLabel), userInfo: nil, repeats: true)
        
    }
    func updateTimeLabel() {
        timePassed += 0.1
        if isAuto{
            droppedGearHeight.constant = 0
            timerLabel.text = "\(timePassed)"
            if (timePassed > 15) {
                if (timePassed.truncatingRemainder(dividingBy: 0.2) < 0.1) {
                    self.endMatchButton.layer.backgroundColor = UIColor.white.cgColor
                } else {
                    self.endMatchButton.layer.backgroundColor = UIColor(colorLiteralRed: 237/255, green: 106/255, blue: 90/255, alpha: 1).cgColor
                }
            }
        }else{
            self.endMatchButton.layer.backgroundColor = UIColor(colorLiteralRed: 237/255, green: 106/255, blue: 90/255, alpha: 1).cgColor
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
    func toAuto() {
        isAuto = true
        timePassed = 0
        currentPeriod.text = "Autonomous"
        otherConstraintOne.constant = 8.5
        otherConstraintTwo.constant = 290
        droppedGearHeight.constant = 0
        gearFailedLabel.text = "Gear Failed Attempt In:"
        boilerPegButton.alpha = 1
        middlePegButton.alpha = 1
        loadingPegButton.alpha = 1
        updateLabels()
    }
    func toTeleop() {
        isAuto = false
        timePassed = 20
        currentPeriod.text = "Teleop"
        otherConstraintOne.constant = 0
        otherConstraintTwo.constant = 0
        droppedGearHeight.constant = 100
        gearFailedLabel.text = ""
        boilerPegButton.alpha = 0
        middlePegButton.alpha = 0
        loadingPegButton.alpha = 0
        updateLabels()

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
        scoutingTeamNumber.text = "Team \(DataModel.currentData!.scoutingTeamNumber)"
        
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
        let halfLowGoalTap = UITapGestureRecognizer(target: self, action: #selector(halfLowGoalPressed))
        halfLowGoalButton.addGestureRecognizer(halfLowGoalTap)
        halfLowGoalButton.isUserInteractionEnabled = true
        
        //Adding the gesture recognizers for the fuel buttons
        let fuelFromHopperTap = UITapGestureRecognizer(target: self, action: #selector(fuelFromHopperPressed))
        fuelFromHopperButton.addGestureRecognizer(fuelFromHopperTap)
        fuelFromHopperButton.isUserInteractionEnabled = true
        
        let fuelFromLoadingStationTap = UITapGestureRecognizer(target: self, action: #selector(fuelFromLoadingStationPressed))
        fuelFromLoadingStationButton.addGestureRecognizer(fuelFromLoadingStationTap)
        fuelFromLoadingStationButton.isUserInteractionEnabled = true
        
        let gearsGroundIntakeTap = UITapGestureRecognizer(target: self, action: #selector(gearsGroundIntakePressed))
        gearsGroundIntakeButton.addGestureRecognizer(gearsGroundIntakeTap)
        gearsGroundIntakeButton.isUserInteractionEnabled = true
        
        let gearsFromLoadingStationTap = UITapGestureRecognizer(target: self, action: #selector(gearsFromLoadingStationPressed))
        gearsFromLoadingStationButton.addGestureRecognizer(gearsFromLoadingStationTap)
        gearsFromLoadingStationButton.isUserInteractionEnabled = true
        
        let gearsDroppedAtLoadingStationTap = UITapGestureRecognizer(target: self, action: #selector(gearsDroppedAtLoadingStationPressed))
        gearsDroppedAtLoadingStationButton.addGestureRecognizer(gearsDroppedAtLoadingStationTap)
        gearsDroppedAtLoadingStationButton.isUserInteractionEnabled = true
        
        redoButton.isHidden = true
        
        
//        gearButton.backgroundColor = UIColor(colorLiteralRed: 60/255, green: 110/255, blue: 113/255, alpha: 1)
        
    }
    
    func gearButtonTapped(){
        hideSelectedContentView()
        active = 0
        showSelectedContentView()
        
    }
    
    @IBAction func pegButtonPressed(_ sender: UIButton) {
        
        
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            sender.alpha = 0
            
        }) { (done) in
            if done{
                sender.alpha = 1.0
            }
        }
        let currentPegPosition = sender.titleLabel!.text!
        
        let action = Action(isAuto: isAuto, time: timePassed, action: Action.RobotAction.GearPlaced)
        switch currentPegPosition {
        case "Boiler Peg":
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
        DataModel.currentData!.printData()
        
        updateLabels()
    }
    
    @IBAction func failedPegButtonPressed(_ sender: UIButton) {
        
        
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            sender.alpha = 0
            
        }) { (done) in
            if done{
                sender.alpha = 1.0
            }
        }
        let currentPegPosition = sender.titleLabel!.text!
        
        let action = Action(isAuto: isAuto, time: timePassed, action: Action.RobotAction.GearFailed)
        switch currentPegPosition {
        case "Boiler Peg":
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
        DataModel.currentData!.printData()
        
        updateLabels()
    }
    
    func droppedGearButtonPressed(){
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.droppedGearButton.alpha = 0
            
        }) { (done) in
            if done{
                self.droppedGearButton.alpha = 1.0
            }
        }
        let action = Action(isAuto: isAuto, time: timePassed, action: Action.RobotAction.GearDropped)
        print("gearDropped")
        updateLabels()
    }
    
    @IBAction func pressureButtonTapped(_ sender: Any) {
        hideSelectedContentView()
        active = 2
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
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.highGoalsScoredButton.alpha = 0
            
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
        
        let action = Action(isAuto: isAuto, time: timePassed, action: Action.RobotAction.HighGoal)
        
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
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.highGoalsMissedButton.alpha = 0
            
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
        
        let action = Action(isAuto: isAuto, time: timePassed, action: Action.RobotAction.HighGoal)
        
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
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.lowGoalDumpButton.alpha = 0
            
        }) { (done) in
            if done{
                self.lowGoalDumpButton.alpha = 1.0
            }
        }
        print("lowGoal")
        let action = Action(isAuto: isAuto, time: timePassed, action: Action.RobotAction.LowGoal)
        action.lowGoal(full: true)
        updateLabels()
    }
    
    func halfLowGoalPressed(){
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.halfLowGoalButton.alpha = 0
            
        }) { (done) in
            if done{
                self.halfLowGoalButton.alpha = 1.0
            }
        }
        print("half lowGoal")
        let action = Action(isAuto: isAuto, time: timePassed, action: Action.RobotAction.LowGoal)
        action.lowGoal(full: false)
        updateLabels()
    }
    
    
    func fuelButtonTapped(){
        hideSelectedContentView()
        active = 1
        showSelectedContentView()
    }
    
    func fuelFromHopperPressed(){
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.fuelFromHopperButton.alpha = 0
            
        }) { (done) in
            if done{
                self.fuelFromHopperButton.alpha = 1.0
            }
        }
        print("fuel hopper")
        let action = Action(isAuto: isAuto, time: timePassed, action: Action.RobotAction.FuelRetrieved)
        action.fuelRetrieved(source: Action.FuelRetrievalPositions.Hopper)
        updateLabels()
        
    }
    
    func fuelFromLoadingStationPressed(){
        
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.fuelFromLoadingStationButton.alpha = 0
            
        }) { (done) in
            if done{
                self.fuelFromLoadingStationButton.alpha = 1.0
            }
        }
        print("fuel loading")
        let action = Action(isAuto: isAuto, time: timePassed, action: Action.RobotAction.FuelRetrieved)
        action.fuelRetrieved(source: Action.FuelRetrievalPositions.LoadingStation)
        DataModel.currentData!.printData()
        updateLabels()
    }
    
    func gearsGroundIntakePressed(){
        
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.gearsGroundIntakeButton.alpha = 0
            
        }) { (done) in
            if done{
                self.gearsGroundIntakeButton.alpha = 1.0
            }
        }
        print("gear ground")
        let action = Action(isAuto: isAuto, time: timePassed, action: Action.RobotAction.GearRetrieved)
        action.gearRetrieved(source: Action.GearRetrievalPositions.Ground)
        DataModel.currentData!.printData()
        updateLabels()
    }
    
    func gearsFromLoadingStationPressed(){
        
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.gearsFromLoadingStationButton.alpha = 0
            
        }) { (done) in
            if done{
                self.gearsFromLoadingStationButton.alpha = 1.0
            }
        }
        print("gear loading")
        let action = Action(isAuto: isAuto, time: timePassed, action: Action.RobotAction.GearRetrieved)
        action.gearRetrieved(source: Action.GearRetrievalPositions.LoadingStation)
        DataModel.currentData!.printData()
        updateLabels()
    }
    
    func gearsDroppedAtLoadingStationPressed(){
        
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.gearsDroppedAtLoadingStationButton.alpha = 0
            
        }) { (done) in
            if done{
                self.gearsDroppedAtLoadingStationButton.alpha = 1.0
            }
        }
        print("gear dropped")
        let action = Action(isAuto: isAuto, time: timePassed, action: Action.RobotAction.GearRetrieved)
        action.gearRetrieved(source: Action.GearRetrievalPositions.Dropped)
        DataModel.currentData!.printData()
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
//        let action = Action(isAuto: isAuto, time: timePassed, action: Action.RobotAction.BaselineCrossed)
//        otherConstraintOne.constant = 0
//        otherConstraintTwo.constant = 0
        
        if let baseline = DataModel.currentData!.data["auto_baseline"] as? Int {
            print(baseline)
            if(baseline == 1) {
                DataModel.currentData!.data["auto_baseline"] = 0
                UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    self.baselineButton.layer.borderWidth = 0
                    self.baselineButton.layer.backgroundColor = UIColor(colorLiteralRed: 112/255, green: 174/255, blue: 110/255, alpha: 1).cgColor
//                    UIColor(red)
                    self.baselineButton.setTitleColor(UIColor.white, for: .normal)
                })
                return
            }
        }
        DataModel.currentData!.data["auto_baseline"] = 1
        print(DataModel.currentData!.data["auto_baseline"])
        UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.baselineButton.layer.borderColor = UIColor(colorLiteralRed: 112/255, green: 174/255, blue: 110/255, alpha: 1).cgColor
            self.baselineButton.layer.borderWidth = 1
            self.baselineButton.layer.backgroundColor = UIColor.white.cgColor
            self.baselineButton.setTitleColor(UIColor(colorLiteralRed: 112/255, green: 174/255, blue: 110/255, alpha: 1), for: .normal)
            
        })
    }
    @IBAction func noActionPressed(_ sender: Any) {
        //        let action = Action(isAuto: isAuto, time: timePassed, action: Action.RobotAction.NoAction)
        var key: String
        if (isAuto) {
            key = "auto_no_action"
        }else{
            key = "tele_no_action"
        }
        if let baseline = DataModel.currentData!.data[key] as? Int {
            if(baseline == 1) {
                DataModel.currentData!.data[key] = 0
                UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    self.noActionButton.layer.borderWidth = 0
                    self.noActionButton.layer.backgroundColor = UIColor(colorLiteralRed: 224/255, green: 116/255, blue: 59/255, alpha: 1).cgColor
                    self.noActionButton.setTitleColor(UIColor.white, for: .normal)
                })
                return
            }
        }
        DataModel.currentData!.data[key] = 1
        UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.noActionButton.layer.borderColor = UIColor(colorLiteralRed: 224/255, green: 116/255, blue: 59/255, alpha: 1).cgColor
            self.noActionButton.layer.borderWidth = 1
            self.noActionButton.layer.backgroundColor = UIColor.white.cgColor
            self.noActionButton.setTitleColor(UIColor(colorLiteralRed: 224/255, green: 116/255, blue: 59/255, alpha: 1), for: .normal)
            
        })
        
    }
    @IBAction func brokeDownPressed(_ sender: Any) {
        //        let action = Action(time: timePassed, action: Action.RobotAction.BreakDown)
        var key: String
        if (isAuto) {
            key = "auto_broke_down"
        }else{
            key = "tele_broke_down"
        }
        if let baseline = DataModel.currentData!.data[key] as? Int {
            if(baseline == 1) {
                DataModel.currentData!.data[key] = 0
                UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    self.brokeDownButton.layer.borderWidth = 0
                    self.brokeDownButton.layer.backgroundColor = UIColor(colorLiteralRed: 237/255, green: 106/255, blue: 90/255, alpha: 1).cgColor
                    self.brokeDownButton.setTitleColor(UIColor.white, for: .normal)
                })
                return
            }
        }
        DataModel.currentData!.data[key] = 1
        UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.brokeDownButton.layer.borderColor = UIColor(colorLiteralRed: 237/255, green: 106/255, blue: 90/255, alpha: 1).cgColor
            self.brokeDownButton.layer.borderWidth = 1
            self.brokeDownButton.layer.backgroundColor = UIColor.white.cgColor
            self.brokeDownButton.setTitleColor(UIColor(colorLiteralRed: 237/255, green: 106/255, blue: 90/255, alpha: 1), for: .normal)
            
        })
    }
    
    
    
    
    @IBAction func undoButtonPressed(_ sender: UIButton) {
        print("pressed")
        DataModel.currentData!.undoAction(isAuto)
        updateLabels()
        if ((isAuto && !DataModel.currentData!.autoUndidActions.isEmpty) || (!isAuto && !DataModel.currentData!.teleUndidActions.isEmpty)) && redoButton.isHidden {
            redoButton.isHidden = false
            redoButton.animation = "slideUp"
            redoButton.force = 0.1
            redoButton.animate()
        }
    }
    
    @IBAction func redoButtonPressed(_ sender: Any) {
        DataModel.currentData!.redoAction(isAuto)
        updateLabels()
//        print(DataModel.currentData!.undidActions)
        if ((isAuto && DataModel.currentData!.autoUndidActions.isEmpty) || (!isAuto && DataModel.currentData!.teleUndidActions.isEmpty)) {
            redoButton.animation = "fadeOut"
            redoButton.animate()
            redoButton.isHidden = true
        }
    }
    
    
    func updateLabels(){
        print("updatingLabels")
        var totalGearsPlaced : Int = 0
        var totalGearsFailed : Int = 0
        var totalGearsDropped : Int = 0
        var totalSuccessfulHighGoals : Float = 0
        var totalUnsuccessfulHighGoals : Float = 0
        var totalLowGoalDumps : Float = 0
        var totalHalfLowGoal : Float = 0
        var totalFuelRetrievedFromLoadingStation : Int = 0
        var totalFuelRetrievedFromHoppers : Int = 0
        var totalGearsRetrievedFromGround : Int = 0
        var totalGearsRetrievedFromLoadingStation : Int = 0
        var totalGearsDroppedAtLoadingStation : Int = 0
        
        var actions: [Action]
        
        if (isAuto) {
            actions = DataModel.currentData!.autoActions
        } else {
            actions = DataModel.currentData!.teleActions
        }
        
        for actionX in actions {
            print(actionX.action)
            switch actionX.action {
            case Action.RobotAction.GearPlaced:
                totalGearsPlaced += 1
                print("gears-placed")
                break
            case Action.RobotAction.GearFailed:
                totalGearsFailed += 1
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
                    totalUnsuccessfulHighGoals += 0.5
                }
                break
            case Action.RobotAction.LowGoal:
                if actionX.fullLowGoal! == true{
                    totalLowGoalDumps += 1
                }else{
                    totalHalfLowGoal += 0.5
                }
                break
            case Action.RobotAction.FuelRetrieved:
                if actionX.fuelRetrievialSource == Action.FuelRetrievalPositions.LoadingStation{
                    totalFuelRetrievedFromLoadingStation += 1
                }else{
                    totalFuelRetrievedFromHoppers += 1
                }
                break
            case Action.RobotAction.GearRetrieved:
                if actionX.gearRetrievialSource == Action.GearRetrievalPositions.LoadingStation{
                    totalGearsRetrievedFromLoadingStation += 1
                }else if actionX.gearRetrievialSource == Action.GearRetrievalPositions.Ground{
                    totalGearsRetrievedFromGround += 1
                }else{
                    totalGearsDroppedAtLoadingStation += 1
                }
                break
            default:
                break
            }
        }
        totalGearsPlacedLabel.text = "Placed: \(totalGearsPlaced)"
        if (isAuto) {
            gearFailedCount.text = "Failed: \(totalGearsFailed)"
        } else {
            gearFailedCount.text = ""
        }
        droppedGearLabel.text = "Dropped: \(totalGearsDropped)"
        totalHighGoalsScoredLabel.text = "Total: \(totalSuccessfulHighGoals)"
        totalHighGoalsMissedButton.text = "Total: \(totalUnsuccessfulHighGoals)"
        self.totalLowGoalDumps.text = "Total: \(totalLowGoalDumps)"
        self.totalHalfLowGoal.text = "Total: \(totalHalfLowGoal)"
        self.totalHighGoals.text = "Total High Cycles: \(totalSuccessfulHighGoals + totalUnsuccessfulHighGoals)"
        self.totalLowGoals.text = "Total Low Cycles: \(totalLowGoalDumps + totalHalfLowGoal)"
        totalFuelFromHopperCollected.text = "Total: \(totalFuelRetrievedFromHoppers)"
        totalFuelFromLoadingStation.text = "Total: \(totalFuelRetrievedFromLoadingStation)"
        totalGearsGroundIntake.text = "Total: \(totalGearsRetrievedFromGround)"
        totalGearsFromLoadingStation.text = "Total: \(totalGearsRetrievedFromLoadingStation)"
        self.totalGearsDroppedAtLoadingStation.text = "Total: \(totalGearsDroppedAtLoadingStation)"
        
        if let baseline = DataModel.currentData!.data["auto_baseline"] as? Int {
            if(baseline == 1) {
                UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    self.baselineButton.layer.borderColor = UIColor(colorLiteralRed: 112/255, green: 174/255, blue: 110/255, alpha: 1).cgColor
                    self.baselineButton.layer.borderWidth = 1
                    self.baselineButton.layer.backgroundColor = UIColor.white.cgColor
                    self.baselineButton.setTitleColor(UIColor(colorLiteralRed: 112/255, green: 174/255, blue: 110/255, alpha: 1), for: .normal)
                    
                })
            } else {
                UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    self.baselineButton.layer.borderWidth = 0
                    self.baselineButton.layer.backgroundColor = UIColor(colorLiteralRed: 112/255, green: 174/255, blue: 110/255, alpha: 1).cgColor
                    self.baselineButton.setTitleColor(UIColor.white, for: .normal)
                })
            }
        } else {
            UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.baselineButton.layer.borderWidth = 0
                self.baselineButton.layer.backgroundColor = UIColor(colorLiteralRed: 112/255, green: 174/255, blue: 110/255, alpha: 1).cgColor
                self.baselineButton.setTitleColor(UIColor.white, for: .normal)
            })
        }
        var nkey: String
        if (isAuto) {
            nkey = "auto_no_action"
        }else{
            nkey = "tele_no_action"
        }
        if let baseline = DataModel.currentData!.data[nkey] as? Int {
            if(baseline == 1) {
                UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    self.noActionButton.layer.borderColor = UIColor(colorLiteralRed: 224/255, green: 116/255, blue: 59/255, alpha: 1).cgColor
                    self.noActionButton.layer.borderWidth = 1
                    self.noActionButton.layer.backgroundColor = UIColor.white.cgColor
                    self.noActionButton.setTitleColor(UIColor(colorLiteralRed: 224/255, green: 116/255, blue: 59/255, alpha: 1), for: .normal)
                    
                })
            } else {
                UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    self.noActionButton.layer.borderWidth = 0
                    self.noActionButton.layer.backgroundColor = UIColor(colorLiteralRed: 224/255, green: 116/255, blue: 59/255, alpha: 1).cgColor
                    self.noActionButton.setTitleColor(UIColor.white, for: .normal)
                })
            }
        } else {
            UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.noActionButton.layer.borderWidth = 0
                self.noActionButton.layer.backgroundColor = UIColor(colorLiteralRed: 224/255, green: 116/255, blue: 59/255, alpha: 1).cgColor
                self.noActionButton.setTitleColor(UIColor.white, for: .normal)
            })
        }
        var bkey: String
        if (isAuto) {
            bkey = "auto_broke_down"
        }else{
            bkey = "tele_broke_down"
        }
        if let baseline = DataModel.currentData!.data[bkey] as? Int {
            if(baseline == 1) {
                UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    self.brokeDownButton.layer.borderColor = UIColor(colorLiteralRed: 237/255, green: 106/255, blue: 90/255, alpha: 1).cgColor
                    self.brokeDownButton.layer.borderWidth = 1
                    self.brokeDownButton.layer.backgroundColor = UIColor.white.cgColor
                    self.brokeDownButton.setTitleColor(UIColor(colorLiteralRed: 237/255, green: 106/255, blue: 90/255, alpha: 1), for: .normal)
                    
                })
            } else {
                UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    self.brokeDownButton.layer.borderWidth = 0
                    self.brokeDownButton.layer.backgroundColor = UIColor(colorLiteralRed: 237/255, green: 106/255, blue: 90/255, alpha: 1).cgColor
                    self.brokeDownButton.setTitleColor(UIColor.white, for: .normal)
                })
            }
        } else {
            UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.brokeDownButton.layer.borderWidth = 0
                self.brokeDownButton.layer.backgroundColor = UIColor(colorLiteralRed: 237/255, green: 106/255, blue: 90/255, alpha: 1).cgColor
                self.brokeDownButton.setTitleColor(UIColor.white, for: .normal)
            })
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        if isAuto {
            let alert = UIAlertController(title: "Cancel Match Confirmation", message: "Are you sure you want to cancel this match?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
                self.performSegue(withIdentifier: "unwindAutoToPrematch", sender: nil)
//                DataModel.currentData!.clearData()
            }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
            }))
            self.present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Go Back Confirmation", message: "Are you sure you want to go back to Autonomous?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
//                self.performSegue(withIdentifier: "endMatch", sender: self)
                self.toAuto()
                self.updateLabels()
            }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func endMatchButtonPressed(_ sender: Any) {
        if isAuto {
            let alert = UIAlertController(title: "Continue Confirmation", message: "Are you sure you want to continue?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
                self.toTeleop()
                self.updateLabels()
            }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
            }))
            self.present(alert, animated: true, completion: nil)
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
    
    @IBAction func autoUnwind(unwindSegue: UIStoryboardSegue) {
        
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
