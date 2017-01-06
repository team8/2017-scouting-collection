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
    
    static var currentMatch: DataModel?
    static var matches = [DataModel]()
    
    //Core Data Managed Object
    var managedObject: NSManagedObject?
    
    //Prematch
    var name: String?
    var teamNumber: Int?
    var matchNumber: Int?
    
    //Auto
    var autoDrive: Bool = false
    var autoNoAction: Bool = false
    var autoBrokeDown: Bool = false
    var autoCollision: Bool = false
    
    var autoReach: Bool = false
    
    var autoLowGoalSuccess: Int = 0
    var autoLowGoalFailure: Int = 0
    var autoHighGoalSuccess: Int = 0
    var autoHighGoalFailure: Int = 0
    
    var autoLowBarSuccess: Int = 0
    var autoLowBarFailure: Int = 0
    var autoDef1Success: Int = 0
    var autoDef1Failure: Int = 0
    var autoDef2Success: Int = 0
    var autoDef2Failure: Int = 0
    var autoDef3Success: Int = 0
    var autoDef3Failure: Int = 0
    var autoDef4Success: Int = 0
    var autoDef4Failure: Int = 0
    
    //Teleop
    var teleopDrive: Bool = false
    var teleopNoAction: Bool = false
    var teleopBrokeDown: Bool = false
    
    var teleopShotsBlocked: Int = 0
    
    var teleopLowGoalSuccess: Int = 0
    var teleopLowGoalFailure: Int = 0
    var teleopHighGoalSuccess: Int = 0
    var teleopHighGoalFailure: Int = 0
    
    var teleopLowBarSuccess: Int = 0
    var teleopLowBarFailure: Int = 0
    var teleopDef1Success: Int = 0
    var teleopDef1Failure: Int = 0
    var teleopDef2Success: Int = 0
    var teleopDef2Failure: Int = 0
    var teleopDef3Success: Int = 0
    var teleopDef3Failure: Int = 0
    var teleopDef4Success: Int = 0
    var teleopDef4Failure: Int = 0
    
    //Endgame
    var challenge: Bool = false
    var scale: Bool = true
    var notes: String?
    
    init(source: NSManagedObject) {
        self.managedObject = source
        self.name = source.value(forKey: "name") as! String?
        self.teamNumber = source.value(forKey: "teamNumber") as! Int?
        self.matchNumber = source.value(forKey: "matchNumber") as! Int?
    }
    
    init() {
    }
    
    func getJSON() -> NSDictionary {
        //TODO
        return NSDictionary()
    }
    
    //Save to Core Data
    func save() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.getContext()
        if self.managedObject == nil {
            let entity =  NSEntityDescription.entity(forEntityName: "Data", in:managedContext)
            self.managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
            DataModel.matches.append(self)
        }
        
        self.managedObject!.setValue(self.name, forKey: "name")
        self.managedObject!.setValue(self.teamNumber, forKey: "teamNumber")
        self.managedObject!.setValue(self.matchNumber, forKey: "matchNumber")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    static func reloadCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Data")
        do {
            let results = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            DataModel.matches = [DataModel]()
            for data in results {
                DataModel.matches.append(DataModel(source: data))
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
}
