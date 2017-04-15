//
//  Action.swift
//  2017 Scouting Collection
//
//  Created by Ujjwal Nadhani on 2/4/17.
//  Copyright © 2017 Paly Robotics. All rights reserved.
//

import Foundation

class Action{
    
    var time : Float
    var action : RobotAction
    
    var inPeg: Pegs?
    
    var highGoalSuccessful : Bool?
    var fullLowGoal : Bool?
    var shootingPosition : ShootingPosition?
    
    var fuelRetrievialSource : FuelRetrievalPositions?
    var gearRetrievialSource : GearRetrievalPositions?
    
    enum RobotAction{
        case GearPlaced
        case GearFailed
        case GearDropped
        case HighGoal
        case LowGoal
        case FuelRetrieved
        case GearRetrieved
        
        case BaselineCrossed
        case NoAction
        case BreakDown
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
        case LoadingStation
    }
    
    enum GearRetrievalPositions{
        case LoadingStation
        case Ground
        case Dropped
    }
    
    init(isAuto: Bool, time: Float, action: RobotAction){
        
        self.time = time
        self.action = action
        if (isAuto) {
            DataModel.currentData!.autoActions.append(self)
        } else {
            DataModel.currentData!.teleActions.append(self)
        }
        print(self.time	)
    }
    
    public func gearPlaced(pegPosition: Pegs){
        inPeg = pegPosition
        print("registered in \(inPeg)")
    }
    
    public func highGoal(successful: Bool, shootingPosition : ShootingPosition){
        highGoalSuccessful = successful
        self.shootingPosition = shootingPosition
    }
    
    public func lowGoal(full: Bool){
        fullLowGoal = full
    }
    
    public func fuelRetrieved(source : FuelRetrievalPositions){
        fuelRetrievialSource = source
    }
    
    public func gearRetrieved(source : GearRetrievalPositions){
        gearRetrievialSource = source
    }
    
    

}
