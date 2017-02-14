//
//  Action.swift
//  2017 Scouting Collection
//
//  Created by Ujjwal Nadhani on 2/4/17.
//  Copyright © 2017 Paly Robotics. All rights reserved.
//

import Foundation

class Action{
    
    var time : Int
    var action : RobotAction
    
    var inPeg: Pegs?
    
    var highGoalSuccessful : Bool?
    var shootingPosition : ShootingPosition?
    
    var fuelRetrievialSource : FuelRetrievalPositions?
    
    enum RobotAction{
        case GearPlaced
        case GearDropped
        case HighGoal
        case LowGoal
        case FuelRetrieved
    }
    
    enum Pegs{
        case Key
        case Middle
        case Loading
    }
    enum ShootingPosition{
        case InsideKey
        case OutsideKey
    }
    
    enum FuelRetrievalPositions{
        case Hopper
        case AllainceStation
    }
    
    init(time: Int, action : RobotAction){
        
        self.time = Int(time)
        self.action = action
        
        DataModel.actions.append(self)
    }
    
    public func gearPlaced(pegPosition: Pegs){
        inPeg = pegPosition
        print("registered in \(inPeg)")
    }
    
    public func highGoal(successful: Bool, shootingPosition : ShootingPosition){
        highGoalSuccessful = successful
        self.shootingPosition = shootingPosition
    }
    
    public func fuelRetrieved(source : FuelRetrievalPositions){
        fuelRetrievialSource = source
    }
    
    

}
