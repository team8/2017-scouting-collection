//
//  CoreDataModel.swift
//  2017 Scouting Collection
//
//  Created by Alex Tarng on 4/5/17.
//  Copyright © 2017 Paly Robotics. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreData {
    
    var managedObject: NSManagedObject
    
    init(entityName: String) {
        //Getting stuff from the appDelegate
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDel.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)
        
        self.managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
    }
    
    init(_ managedObject: NSManagedObject) {
        self.managedObject = managedObject
    }
    
    func saveToCoreData() {
        //Getting and converting the matchesDict to NSData
        let dict = self.getJSON() as NSDictionary
        print("Saving")
//        print(dict)
        let dataToSave = NSKeyedArchiver.archivedData(withRootObject: dict)
        
        //Getting stuff from the appDelegate
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDel.managedObjectContext
        
        //Creating the managed object and saving the match
        self.managedObject.setValue(dataToSave, forKey: "data")
        self.managedObject.setValue(DataModel.competition, forKey: "event")
        
        //This will succeed 99% of the time
        do{
            print("Saving managed context")
            try managedContext.save()
        }catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func deleteFromCoreData() {
        //Getting stuff from the appDelegate
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDel.managedObjectContext
        //Delete object
        managedContext.delete(self.managedObject)
        //This will succeed 99% of the time
        do{
            try managedContext.save()
        }catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func getJSON() -> NSDictionary {
        preconditionFailure("This method must be overridden")
    }
}
