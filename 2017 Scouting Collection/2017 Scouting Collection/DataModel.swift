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
    
    static var actions = [Action]()
    static var scouterName = String()
    static var matchType : MatchType!
    static var matchNumber : Int = Int()
    static var matchNumberOf : Int?
    static var scoutingTeamNumber : Int = Int()
    static var undidActions = [Action]()
    static var data = [String: Any]()
    
    enum MatchType {
        case Qualifying
        case QuarterFinals
        case SemiFinals
        case Finals
        case Unknown
    }
    
    static public func undoAction(){
        if !(actions.isEmpty){
            let lastAction = actions[actions.count - 1];
            actions.removeLast()
            undidActions.append(lastAction)
        }
    }
    
    static public func redoAction(){
        
        if !(undidActions.isEmpty){
            let lastUndidAction = undidActions[undidActions.count - 1];
            undidActions.removeLast()
            actions.append(lastUndidAction)
        }
    }
    
    static public func printData(){
        print(actions)
    }
    
}
