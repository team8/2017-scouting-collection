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

class DataModel: CoreData {
    
//    static var storedCSVs = [String]()
    static var competition = "2017casj" //temp
    
    static var currentData: DataModel?
    static var dataList = [DataModel]()
    
    var autoActions = [Action]()
    var teleActions = [Action]()
    var scouterName = String()
    var matchType : MatchModel.MatchType!
    var matchNumber : Int = Int()
    var matchNumberOf : Int?
    var scoutingTeamNumber : Int = Int()
    var autoUndidActions = [Action]()
    var teleUndidActions = [Action]()
    var data = [String: Any]()
    
    
    public func undoAction(_ isAuto: Bool){
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
    
    public func redoAction(_ isAuto: Bool){
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
    
    public func printData(){
        print(autoActions)
        print(teleActions)
    }
    
//    public func clearData() {
//        autoActions = [Action]()
//        teleActions = [Action]()
//        scouterName = String()
//        matchType = nil
//        matchNumber = Int()
//        matchNumberOf = nil
//        scoutingTeamNumber = Int()
//        autoUndidActions = [Action]()
//        teleUndidActions = [Action]()
//        data = [String: Any]()
//    }
    
    init() {
        super.init(entityName: "Data")
    }
    
    override init(_ managedObject: NSManagedObject) {
        let unarchivedData : NSData = managedObject.value(forKey: "data") as! NSData
        do {
            let dict: NSDictionary = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(unarchivedData) as! NSDictionary
            self.data = dict as! [String : Any]
            
            super.init(managedObject)
            
        } catch {
            fatalError("core data fetch error")
        }
    }

    override func getJSON() -> NSDictionary {
        return data as NSDictionary
    }
    
    static func saveDataToCoreData() {
        for data in dataList {
            data.saveToCoreData()
        }
    }
    
    static func fetchDataFromCoreData(event: String) {
        //Clear list
        dataList.removeAll()
        
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
                    for (index, i) in managedObjectResults.enumerated() {
                        print(index)
                        if let event = i.value(forKey: "event") {
                            if (event as! String == DataModel.competition) {
//                            if i.value(forKey: "event") as! String == DataModel.competition {
                                dataList.append(DataModel(i))
                            }
                        } else {
                            if let data = i.value(forKey: "data") {
                                print("ecks dee")
                            }
                            print("failed: " + String(index))
                        }
                    }
                }
                
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }

    static func removeDuplicate(_ d1: DataModel) {
        let data1 = d1.data
        if data1["comp_level"] as! String == "pr" {
            return
        }
        var offset = 0
        for (i, d2) in DataModel.dataList.enumerated() {
//            print(String(i) + ":" + d2.CSV())
            let data2 = d2.data
            if (data1["event"] as! String == data2["event"] as! String && data1["comp_level"] as! String == data2["comp_level"] as! String && data1["match_number"] as! Int == data2["match_number"] as! Int && data1["match_in"] as! Int == data2["match_in"] as! Int && data1["scouting_team_number"] as? Int == data2["scouting_team_number"] as? Int) {
                d2.deleteFromCoreData()
                DataModel.dataList.remove(at: i - offset)
                offset += 1
                print("removed")
            }
        }
    }
    
    func getMatch() -> MatchModel? {
        
        for match in MatchModel.matchList {
            var matchIn = -1
            if let m = match.matchIn {
                matchIn = m
            }
            if (data["event"] as! String == DataModel.competition && data["comp_level"] as! String == match.matchType.string && data["match_number"] as! Int == match.matchNumber && data["match_in"] as! Int == matchIn && data["scouting_team_number"] as? Int == match.getTeam()) {
                return match
            }
        }
        return nil
    }
//    static func saveCSVsToCoreData() {
//        //Getting stuff from the appDelegate
//        let appDel = UIApplication.shared.delegate as! AppDelegate
//        let managedContext = appDel.managedObjectContext
//        let entity = NSEntityDescription.entity(forEntityName: "Data", in: managedContext)
//        
//        //Delete saved data
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
//        fetchRequest.entity = entity
//        
//        do {
//            let results = try managedContext.fetch(fetchRequest)
//            if (results.count > 0) {
//                if let managedObjectResults = results as? [NSManagedObject] {
//                    for i: NSManagedObject in managedObjectResults {
//                        managedContext.delete(i)
//                    }
//                }
//                
//            }
//            
//        } catch {
//            let fetchError = error as NSError
//            print(fetchError)
//        }
//        
//        //Creating the managed object and saving the match
//        for csv in DataModel.storedCSVs {
//            let managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
//            managedObject.setValue(csv, forKey: "csv")
//        }
//        //This will succeed 99% of the time
//        do{
//            try managedContext.save()
//        }catch let error as NSError  {
//            print("Could not save \(error), \(error.userInfo)")
//        }
//    }
//    
//    static func fetchCSVsFromCoreData() {
//        //Clear list
//        storedCSVs.removeAll()
//        
//        //Getting stuff from the appDelegate
//        let appDel = UIApplication.shared.delegate as! AppDelegate
//        let managedContext = appDel.managedObjectContext
//        let entity = NSEntityDescription.entity(forEntityName: "Data", in: managedContext)
//        
//        //Fetch Request
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
//        fetchRequest.entity = entity
//        
//        do {
//            let results = try managedContext.fetch(fetchRequest)
//            if (results.count > 0) {
//                if let managedObjectResults = results as? [NSManagedObject] {
//                    for i: NSManagedObject in managedObjectResults {
//                        storedCSVs.append(i.value(forKey: "csv") as! String)
//                    }
//                }
//                
//            }
//            
//        } catch {
//            let fetchError = error as NSError
//            print(fetchError)
//        }
//    }
    
    public func compile() {
        var gears = [0,0]
        var autoGearsFailed = 0
        var autoGearsFailedPositions = ""
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
                actions = autoActions
            } else {
                actions = teleActions
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
                case Action.RobotAction.GearFailed:
                    autoGearsFailed += 1
                    if actionX.inPeg! == Action.Pegs.Key {
                        autoGearsFailedPositions += "b;"
                    } else if actionX.inPeg! == Action.Pegs.Middle{
                        autoGearsFailedPositions += "m;"
                    } else {
                        autoGearsFailedPositions += "l;"
                    }
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
        data["name"] = scouterName
        data["comp_level"] = matchType.string
        data["match_number"] = matchNumber
        data["match_in"] = matchIn
        data["scouting_team_number"] = scoutingTeamNumber
        data["auto_gears"] = String(gears[0])
        data["auto_gears_positions"] = autoGearPositions
        data["auto_gears_failed"] = String(autoGearsFailed)
        data["auto_gears_failed_positions"] = String(autoGearsFailedPositions)
        data["auto_gears_intake_ground"] = String(gearsIntakeGround[0])
        data["auto_fuel_high_cycles"] = String(highGoals[0])
        data["auto_fuel_high_cycles_positions"] = autoHighGoalsPositions
        data["auto_fuel_low_cycles"] = String(lowGoals[0])
        data["auto_fuel_intake_hopper"] = String(fuelIntakeHopper[0])
        data["tele_gears_cycles"] = String(gears[1])
        data["tele_gears_cycles_boiler"] = String(teleGearPositions[0])
        data["tele_gears_cycles_middle"] = String(teleGearPositions[1])
        data["tele_gears_cycles_loading"] = String(teleGearPositions[2])
        data["tele_gears_dropped"] = String(gearsDropped[1])
        data["tele_gears_intake_ground"] = String(gearsIntakeGround[1])
        data["tele_gears_intake_loading_station"] = String(teleGearsIntakeLoadingStation)
        data["tele_gears_intake_dropped"] = String(teleGearsIntakeDropped)
        data["tele_gears_cycles_times"] = teleGearsCycleTimes
        data["tele_fuel_high_cycles"] = String(highGoals[1])
        data["tele_fuel_high_cycles_in_key"] = String(teleHighGoalsPositions[0])
        data["tele_fuel_high_cycles_out_of_key"] = String(teleHighGoalsPositions[1])
        data["tele_fuel_high_cycles_times"] = teleHighCycleTimes
        data["tele_fuel_low_cycles"] = String(lowGoals[1])
        data["tele_fuel_low_cycles_times"] = teleLowCycleTimes
        data["tele_fuel_intake_hopper"] = String(fuelIntakeHopper[1])
        data["tele_fuel_intake_loading_station"] = String(teleFuelIntakeLoadingStation)
        data["event"] = DataModel.competition
    }
    
    public func CSV() -> String {
        let retVal = String(describing: data["name"]!) + "," +
            String(describing: data["comp_level"]!) + "," +
            String(describing: data["match_number"]!) + "," +
            String(describing: data["match_in"]!) + "," +
            String(describing: data["scouting_team_number"]!) + "," +
            String(describing: data["auto_baseline"]!) + "," +
            String(describing: data["auto_no_action"]!) + "," +
            String(describing: data["auto_broke_down"]!) + "," +
            String(describing: data["auto_gears"]!) + "," +
            String(describing: data["auto_gears_positions"]!) + "," +
            String(describing: data["auto_gears_failed"]!) + "," +
            String(describing: data["auto_gears_failed_positions"]!) + "," +
            String(describing: data["auto_gears_intake_ground"]!) + "," +
            String(describing: data["auto_fuel_high_cycles"]!) + "," +
            String(describing: data["auto_fuel_high_cycles_positions"]!) + "," +
            String(describing: data["auto_fuel_low_cycles"]!) + "," +
            String(describing: data["auto_fuel_intake_hopper"]!) + "," +
            String(describing: data["tele_no_action"]!) + "," +
            String(describing: data["tele_broke_down"]!) + "," +
            String(describing: data["tele_gears_cycles"]!) + "," +
            String(describing: data["tele_gears_cycles_boiler"]!) + "," +
            String(describing: data["tele_gears_cycles_middle"]!) + "," +
            String(describing: data["tele_gears_cycles_loading"]!) + "," +
            String(describing: data["tele_gears_dropped"]!) + "," +
            String(describing: data["tele_gears_intake_ground"]!) + "," +
            String(describing: data["tele_gears_intake_loading_station"]!) + "," +
            String(describing: data["tele_gears_intake_dropped"]!) + "," +
            String(describing: data["tele_gears_cycles_times"]!) + "," +
            String(describing: data["tele_fuel_high_cycles"]!) + "," +
            String(describing: data["tele_fuel_high_cycles_in_key"]!) + "," +
            String(describing: data["tele_fuel_high_cycles_out_of_key"]!) + "," +
            String(describing: data["tele_fuel_high_cycles_times"]!) + "," +
            String(describing: data["tele_fuel_low_cycles"]!) + "," +
            String(describing: data["tele_fuel_low_cycles_times"]!) + "," +
            String(describing: data["tele_fuel_intake_hopper"]!) + "," +
            String(describing: data["tele_fuel_intake_loading_station"]!) + "," +
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
            String(describing: data["event"]!)
        return retVal
    }
}
