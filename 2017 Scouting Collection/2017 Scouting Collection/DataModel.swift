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
    var drive: Bool = false
    var noAction: Bool = false
    var brokeDown: Bool = false
    var collision: Bool = false
    
    var reach: Bool = false
    
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
