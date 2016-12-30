//
//  DataModel.swift
//  2017 Scouting Collection
//
//  Created by Alex Tarng on 12/22/16.
//  Copyright © 2016 Paly Robotics. All rights reserved.
//

import Foundation

class Data {
    
    static var currentMatch: Data?
    
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
    var notes: String?
    
    init(name: String, teamNumber: Int, matchNumber: Int) {
        self.name = name
        self.teamNumber = teamNumber
        self.matchNumber = matchNumber
    }
    
    
    func getJSON() -> NSDictionary {
        //TODO
        return NSDictionary()
    }
}
