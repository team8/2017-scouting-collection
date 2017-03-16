//
//  DataModel.swift
//  2017 Scouting Collection
//
//  Created by Alex Tarng on 12/22/16.
//  Copyright © 2016 Paly Robotics. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataModel {
    
    static var storedCSVs = [String]()
    
    static var autoActions = [Action]()
    static var teleActions = [Action]()
    static var scouterName = String()
    static var matchType : MatchType!
    static var matchNumber : Int = Int()
    static var matchNumberOf : Int?
    static var scoutingTeamNumber : Int = Int()
    static var autoUndidActions = [Action]()
    static var teleUndidActions = [Action]()
    static var data = [String: Any]()
    
    enum MatchType {
        case Qualifying
        case QuarterFinals
        case SemiFinals
        case Finals
        case Unknown
        
        var string: String {
            switch self {
            case .Qualifying: return "qm";
            case .QuarterFinals: return "qf";
            case .SemiFinals: return "sf";
            case .Finals: return "f";
            default: return "un"
            }
        }
    }
    
    static public func undoAction(_ isAuto: Bool){
        if(isAuto) {
            if !(autoActions.isEmpty){
                let lastAction = autoActions[autoActions.count - 1];
                autoActions.removeLast()
                autoUndidActions.append(lastAction)
            }
        } else {
            if !(teleActions.isEmpty){
                let lastAction = teleActions[teleActions.count - 1];
                teleActions.removeLast()
                teleUndidActions.append(lastAction)
            }
        }
    }
    
    static public func redoAction(_ isAuto: Bool){
        if(isAuto) {
            if !(autoUndidActions.isEmpty){
                let lastUndidAction = autoUndidActions[autoUndidActions.count - 1];
                autoUndidActions.removeLast()
                autoActions.append(lastUndidAction)
            }
        } else {
            if !(teleUndidActions.isEmpty){
                let lastUndidAction = teleUndidActions[teleUndidActions.count - 1];
                teleUndidActions.removeLast()
                teleActions.append(lastUndidAction)
            }
        }
    }
    
    static public func printData(){
        print(autoActions)
        print(teleActions)
    }
    
    static public func clearData() {
        DataModel.autoActions = [Action]()
        DataModel.teleActions = [Action]()
        DataModel.scouterName = String()
        DataModel.matchType = nil
        DataModel.matchNumber = Int()
        DataModel.matchNumberOf = nil
        DataModel.scoutingTeamNumber = Int()
        DataModel.autoUndidActions = [Action]()
        DataModel.teleUndidActions = [Action]()
        DataModel.data = [String: Any]()
    }
    
    static func saveCSVsToCoreData() {
        //Getting stuff from the appDelegate
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDel.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Data", in: managedContext)
        
        //Delete saved data
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entity
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            if (results.count > 0) {
                if let managedObjectResults = results as? [NSManagedObject] {
                    for i: NSManagedObject in managedObjectResults {
                        managedContext.delete(i)
                    }
                }
                
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        //Creating the managed object and saving the match
        for csv in DataModel.storedCSVs {
            let managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
            managedObject.setValue(csv, forKey: "csv")
        }
        //This will succeed 99% of the time
        do{
            try managedContext.save()
        }catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    static func fetchCSVsFromCoreData() {
        //Clear list
        storedCSVs.removeAll()
        
        //Getting stuff from the appDelegate
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDel.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Data", in: managedContext)
        
        //Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entity
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            if (results.count > 0) {
                if let managedObjectResults = results as? [NSManagedObject] {
                    for i: NSManagedObject in managedObjectResults {
                        storedCSVs.append(i.value(forKey: "csv") as! String)
                    }
                }
                
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }
    
    static public func CSV() -> String {
        var gears = [0,0]
        var gearsDropped = [0,0]
        var gearsIntakeGround = [0,0]
        var autoGearPositions = ""
        var teleGearPositions = [0,0,0]
        var highGoals = [0.0,0.0]
        var lowGoals = [0.0,0.0]
        var fuelIntakeHopper = [0,0]
        var autoHighGoalsPositions = ""
        var teleHighGoalsPositions = [0,0]
        var teleGearsIntakeLoadingStation = 0
        var teleGearsIntakeDropped = 0
        var teleGearsCycleTimes = ""
        var teleHighCycleTimes = ""
        var teleLowCycleTimes = ""
        var teleFuelIntakeLoadingStation = 0
        
        var i = 0
        
        while(i<2){
        
            var actions: [Action]
            
            if (i == 0) {
                actions = DataModel.autoActions
            } else {
                actions = DataModel.teleActions
            }
            
            var previousTime: Float?
            var previousPreviousTime: Float?
            
            var gearIntaked = false
            var fuelIntaked = false
            
            for actionX in actions {
                print(actionX.action)
                switch actionX.action {
                case Action.RobotAction.GearPlaced:
                    gears[i] += 1
                    if actionX.inPeg! == Action.Pegs.Key {
                        if(i == 0) {
                            autoGearPositions += "b;"
                        } else {
                            teleGearPositions[0] += 1
                        }
                    } else if actionX.inPeg! == Action.Pegs.Middle{
                        if(i == 0) {
                            autoGearPositions += "m;"
                        } else {
                            teleGearPositions[1] += 1
                        }
                    } else {
                        if(i == 0) {
                            autoGearPositions += "l;"
                        } else {
                            teleGearPositions[2] += 1
                        }
                    }
                    if(i==1) {
                        if(previousTime != nil) {
                            if(!fuelIntaked) {
                                teleGearsCycleTimes += String(actionX.time-previousTime!) + ";"
                            } else {
                                if(previousPreviousTime != nil) {
                                    teleGearsCycleTimes += String(actionX.time-previousPreviousTime!) + ";"
                                }
                                fuelIntaked = false
                            }
                            previousTime = actionX.time
                            previousPreviousTime = previousTime!
                            break
                        }
                        previousTime = actionX.time
                    }
//                    print("gears-placed")
                    break
                case Action.RobotAction.GearDropped:
                    gearsDropped[i] += 1
//                    print("gears-dropped")
                    break
                case Action.RobotAction.HighGoal:
                    if actionX.highGoalSuccessful! == true{
                        highGoals[i] += 1.0
                    }else{
                        highGoals[i] += 0.5
                    }
                    if actionX.shootingPosition! == Action.ShootingPosition.InsideKey {
                        if(i == 0) {
                            autoHighGoalsPositions += "i;"
                        } else {
                            teleHighGoalsPositions[0] += 1
                        }
                    } else {
                        if(i == 0) {
                            autoHighGoalsPositions += "o;"
                        } else {
                            teleHighGoalsPositions[1] += 1
                        }
                    }
                    if (i==1){
                        if(previousTime != nil) {
                            if(!gearIntaked) {
                                teleHighCycleTimes += String(actionX.time-previousTime!) + ";"
                            } else {
                                if(previousPreviousTime != nil) {
                                    teleHighCycleTimes += String(actionX.time-previousPreviousTime!) + ";"
                                }
                                gearIntaked = false
                            }
                            previousTime = actionX.time
                            previousPreviousTime = previousTime!
                            break
                        }
                        previousTime = actionX.time
                    }
                    break
                case Action.RobotAction.LowGoal:
                    if actionX.fullLowGoal! == true{
                        lowGoals[i] += 1
                    }else{
                        lowGoals[i] += 0.5
                    }
                    if(i==1){
                        if(previousTime != nil) {
                            if(!gearIntaked) {
                                teleLowCycleTimes += String(actionX.time-previousTime!) + ";"
                            } else {
                                if(previousPreviousTime != nil) {
                                    teleLowCycleTimes += String(actionX.time-previousPreviousTime!) + ";"
                                }
                                gearIntaked = false
                            }
                            previousTime = actionX.time
                            previousPreviousTime = previousTime!
                            break
                        }
                        previousTime = actionX.time
                    }
                    break
                case Action.RobotAction.FuelRetrieved:
                    if actionX.fuelRetrievialSource! == Action.FuelRetrievalPositions.LoadingStation{
                        teleFuelIntakeLoadingStation += 1
                    }else{
                        fuelIntakeHopper[i] += 1
                    }
                    fuelIntaked = true
                    break
                case Action.RobotAction.GearRetrieved:
                    if actionX.gearRetrievialSource! == Action.GearRetrievalPositions.LoadingStation{
                        teleGearsIntakeLoadingStation += 1
                    }else if actionX.gearRetrievialSource! == Action.GearRetrievalPositions.Ground{
                        gearsIntakeGround[i] += 1
                    }else{
                        teleGearsIntakeDropped += 1
                    }
                    gearIntaked = true
                    break
                default:
                    break
                }
            }
            i += 1
        }
        print(teleGearsCycleTimes)
        print(teleHighCycleTimes)
        print(teleLowCycleTimes)
        var matchIn: Int
        if(matchNumberOf == nil) {
            matchIn = -1
        } else {
            matchIn = matchNumberOf!
        }
        let retVal = scouterName + "," +
            matchType.string + "," +
            String(matchNumber) + "," +
            String(matchIn) + "," +
            String(scoutingTeamNumber) + "," +
            String(describing: data["auto_baseline"]!) + "," +
            String(describing: data["auto_no_action"]!) + "," +
            String(describing: data["auto_broke_down"]!) + "," +
            String(gears[0]) + "," +
            autoGearPositions + "," +
            String(gearsDropped[0]) + "," +
            String(gearsIntakeGround[0]) + "," +
            String(highGoals[0]) + "," +
            autoHighGoalsPositions + "," +
            String(lowGoals[0]) + "," +
            String(fuelIntakeHopper[0]) + "," +
            String(describing: data["tele_no_action"]!) + "," +
            String(describing: data["tele_broke_down"]!) + "," +
            String(gears[1]) + "," +
            String(teleGearPositions[0]) + "," +
            String(teleGearPositions[1]) + "," +
            String(teleGearPositions[2]) + "," +
            String(gearsDropped[1]) + "," +
            String(gearsIntakeGround[1]) + "," +
            String(teleGearsIntakeLoadingStation) + "," +
            String(teleGearsIntakeDropped) + "," +
            teleGearsCycleTimes + "," +
            String(highGoals[1]) + "," +
            String(teleHighGoalsPositions[0]) + "," +
            String(teleHighGoalsPositions[1]) + "," +
            teleHighCycleTimes + "," +
            String(lowGoals[1]) + "," +
            teleLowCycleTimes + "," +
            String(fuelIntakeHopper[1]) + "," +
            String(teleFuelIntakeLoadingStation) + "," +
            String(describing: data["no_show"]!) + "," +
            String(describing: data["takeoff"]!) + "," +
            String(describing: data["takeoff_speed"]!) + "," +
            String(describing: data["defense"]!) + "," +
            String(describing: data["defense_rating"]!) + "," +
            String(describing: data["gear_ground_intake"]!) + "," +
            String(describing: data["gear_ground_intake_rating"]!) + "," +
            String(describing: data["fuel_ground_intake"]!) + "," +
            String(describing: data["fuel_ground_intake_rating"]!) + "," +
            String(describing: data["driver_skill_rating"]!) + "," +
            String(describing: data["notes"]!) + "," +
            "2017cave" //event
        return retVal
    }
}
