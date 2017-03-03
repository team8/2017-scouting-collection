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
    
    static public func CSV() -> String {
//        var retVal = matchNumber + "," +
//            scoutingTeamNumber + "," +
//            matchType.string + "," +
//            data["baseline"]
//        scoringElements["match"] = splitVersion[0]
//        scoringElements["team"] = splitVersion[1]
//        scoringElements["comp_level"] = "qm"
//        scoringElements["auto_baseline"] = splitVersion[2]
//        scoringElements["auto_gears"] = splitVersion[3]
//        scoringElements["auto_gear_positions"] = splitVersion[4]
//        scoringElements["auto_gears_dropped"] = splitVersion[5]
//        scoringElements["auto_high_fuel"] = splitVersion[6]
//        scoringElements["auto_high_fuel_positions"] = splitVersion[7]
//        scoringElements["auto_low_cycles"] = splitVersion[8]
//        scoringElements["auto_intake_hopper"] = splitVersion[9]
//        scoringElements["tele_gears"] = splitVersion[10]
//        scoringElements["tele_gear_positions"] = splitVersion[11]
//        scoringElements["tele_gears_dropped"] = splitVersion[12]
//        scoringElements["tele_high_fuel"] = splitVersion[13]
//        scoringElements["tele_high_fuel_positions"] = splitVersion[14]
//        scoringElements["tele_low_cycles"] = splitVersion[15]
//        scoringElements["tele_intake_hopper"] = splitVersion[16]
//        scoringElements["tele_intake_loading"] = splitVersion[17]
//        scoringElements["tele_defense"] = splitVersion[18]
//        scoringElements["end_climb"] = splitVersion[19]
//        scoringElements["end_ground_intake_gear"] = splitVersion[20]
//        scoringElements["end_ground_intake_fuel"] = splitVersion[21]
//        scoringElements["end_stop_gearing"] = splitVersion[21]
//        scoringElements["end_fouls"] = splitVersion[22]
        return "test"
    }
}
