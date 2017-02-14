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
    //Have to do endgame
    
    enum MatchType {
        case Qualifying
        case QuarterFinals
        case SemiFinals
        case Finals
        case Unknown
    }
    static public func undoAction(){
        DataModel.actions.removeLast()
    }
    static public func printData(){
        print(actions)
    }
    
}
