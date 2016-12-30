//
//  SFDialogViewController.swift
//  2017 Scouting Collection
//
//  Created by Alex Tarng on 12/29/16.
//  Copyright © 2016 Paly Robotics. All rights reserved.
//

import Foundation
import UIKit

class SFDialogViewController: ViewController {
    
    var period: String?
    var parentValue: Int?
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        //someone please make my code better -at
        if(period == "Autonomous") {
            //Autonomous
            switch(parentValue!){
            case 0:
                //Low goal
                switch(sender.tag){
                case 0:
                    //+ Success
                    Data.currentMatch?.autoLowGoalSuccess += 1
                    break
                case 1:
                    //- Success
                    Data.currentMatch?.autoLowGoalSuccess -= 1
                    break
                case 2:
                    //+ Failure
                    Data.currentMatch?.autoLowGoalFailure += 1
                    break
                case 3:
                    //- Failure
                    Data.currentMatch?.autoLowGoalFailure -= 1
                    break
                default:
                    //wat
                    break
                }
                break
            case 1:
                //High goal
                switch(sender.tag){
                case 0:
                    //+ Success
                    Data.currentMatch?.autoHighGoalSuccess += 1
                    break
                case 1:
                    //- Success
                    Data.currentMatch?.autoHighGoalSuccess -= 1
                    break
                case 2:
                    //+ Failure
                    Data.currentMatch?.autoHighGoalFailure += 1
                    break
                case 3:
                    //- Failure
                    Data.currentMatch?.autoHighGoalFailure -= 1
                    break
                default:
                    //wat
                    break
                }
                break
            case 2:
                //Low bar
                switch(sender.tag){
                case 0:
                    //+ Success
                    Data.currentMatch?.autoLowBarSuccess += 1
                    break
                case 1:
                    //- Success
                    Data.currentMatch?.autoLowBarSuccess -= 1
                    break
                case 2:
                    //+ Failure
                    Data.currentMatch?.autoLowBarFailure += 1
                    break
                case 3:
                    //- Failure
                    Data.currentMatch?.autoLowBarFailure -= 1
                    break
                default:
                    //wat
                    break
                }
                break
            case 3:
                //Defense 1
                switch(sender.tag){
                case 0:
                    //+ Success
                    Data.currentMatch?.autoDef1Success += 1
                    break
                case 1:
                    //- Success
                    Data.currentMatch?.autoDef1Success -= 1
                    break
                case 2:
                    //+ Failure
                    Data.currentMatch?.autoDef1Failure += 1
                    break
                case 3:
                    //- Failure
                    Data.currentMatch?.autoDef1Failure -= 1
                    break
                default:
                    //wat
                    break
                }
                break
            case 4:
                //Defense 2
                switch(sender.tag){
                case 0:
                    //+ Success
                    Data.currentMatch?.autoDef2Success += 1
                    break
                case 1:
                    //- Success
                    Data.currentMatch?.autoDef2Success -= 1
                    break
                case 2:
                    //+ Failure
                    Data.currentMatch?.autoDef2Failure += 1
                    break
                case 3:
                    //- Failure
                    Data.currentMatch?.autoDef2Failure -= 1
                    break
                default:
                    //wat
                    break
                }
                break
            case 5:
                //Defense 3
                switch(sender.tag){
                case 0:
                    //+ Success
                    Data.currentMatch?.autoDef3Success += 1
                    break
                case 1:
                    //- Success
                    Data.currentMatch?.autoDef3Success -= 1
                    break
                case 2:
                    //+ Failure
                    Data.currentMatch?.autoDef3Failure += 1
                    break
                case 3:
                    //- Failure
                    Data.currentMatch?.autoDef3Failure -= 1
                    break
                default:
                    //wat
                    break
                }
                
                break
            case 6:
                //Defense 4
                switch(sender.tag){
                case 0:
                    //+ Success
                    Data.currentMatch?.autoDef4Success += 1
                    break
                case 1:
                    //- Success
                    Data.currentMatch?.autoDef4Success -= 1
                    break
                case 2:
                    //+ Failure
                    Data.currentMatch?.autoDef4Failure += 1
                    break
                case 3:
                    //- Failure
                    Data.currentMatch?.autoDef4Failure -= 1
                    break
                default:
                    //wat
                    break
                }
                break
            default:
                //wat
                break
            }
            self.performSegue(withIdentifier: "SFDialogToAuto", sender: self)
        } else if (period == "Teleop") {
            //Teleop
            switch(parentValue!){
            case 0:
                //Low goal
                switch(sender.tag){
                case 0:
                    //+ Success
                    Data.currentMatch?.teleopLowGoalSuccess += 1
                    break
                case 1:
                    //- Success
                    Data.currentMatch?.teleopLowGoalSuccess -= 1
                    break
                case 2:
                    //+ Failure
                    Data.currentMatch?.teleopLowGoalFailure += 1
                    break
                case 3:
                    //- Failure
                    Data.currentMatch?.teleopLowGoalFailure -= 1
                    break
                default:
                    //wat
                    break
                }
                break
            case 1:
                //High goal
                switch(sender.tag){
                case 0:
                    //+ Success
                    Data.currentMatch?.teleopHighGoalSuccess += 1
                    break
                case 1:
                    //- Success
                    Data.currentMatch?.teleopHighGoalSuccess -= 1
                    break
                case 2:
                    //+ Failure
                    Data.currentMatch?.teleopHighGoalFailure += 1
                    break
                case 3:
                    //- Failure
                    Data.currentMatch?.teleopHighGoalFailure -= 1
                    break
                default:
                    //wat
                    break
                }
                break
            case 2:
                //Low bar
                switch(sender.tag){
                case 0:
                    //+ Success
                    Data.currentMatch?.teleopLowBarSuccess += 1
                    break
                case 1:
                    //- Success
                    Data.currentMatch?.teleopLowBarSuccess -= 1
                    break
                case 2:
                    //+ Failure
                    Data.currentMatch?.teleopLowBarFailure += 1
                    break
                case 3:
                    //- Failure
                    Data.currentMatch?.teleopLowBarFailure -= 1
                    break
                default:
                    //wat
                    break
                }
                break
            case 3:
                //Defense 1
                switch(sender.tag){
                case 0:
                    //+ Success
                    Data.currentMatch?.teleopDef1Success += 1
                    break
                case 1:
                    //- Success
                    Data.currentMatch?.teleopDef1Success -= 1
                    break
                case 2:
                    //+ Failure
                    Data.currentMatch?.teleopDef1Failure += 1
                    break
                case 3:
                    //- Failure
                    Data.currentMatch?.teleopDef1Failure -= 1
                    break
                default:
                    //wat
                    break
                }
                break
            case 4:
                //Defense 2
                switch(sender.tag){
                case 0:
                    //+ Success
                    Data.currentMatch?.teleopDef2Success += 1
                    break
                case 1:
                    //- Success
                    Data.currentMatch?.teleopDef2Success -= 1
                    break
                case 2:
                    //+ Failure
                    Data.currentMatch?.teleopDef2Failure += 1
                    break
                case 3:
                    //- Failure
                    Data.currentMatch?.teleopDef2Failure -= 1
                    break
                default:
                    //wat
                    break
                }
                break
            case 5:
                //Defense 3
                switch(sender.tag){
                case 0:
                    //+ Success
                    Data.currentMatch?.teleopDef3Success += 1
                    break
                case 1:
                    //- Success
                    Data.currentMatch?.teleopDef3Success -= 1
                    break
                case 2:
                    //+ Failure
                    Data.currentMatch?.teleopDef3Failure += 1
                    break
                case 3:
                    //- Failure
                    Data.currentMatch?.teleopDef3Failure -= 1
                    break
                default:
                    //wat
                    break
                }
                
                break
            case 6:
                //Defense 4
                switch(sender.tag){
                case 0:
                    //+ Success
                    Data.currentMatch?.teleopDef4Success += 1
                    break
                case 1:
                    //- Success
                    Data.currentMatch?.teleopDef4Success -= 1
                    break
                case 2:
                    //+ Failure
                    Data.currentMatch?.teleopDef4Failure += 1
                    break
                case 3:
                    //- Failure
                    Data.currentMatch?.teleopDef4Failure -= 1
                    break
                default:
                    //wat
                    break
                }
                break
            default:
                //wat
                break
            }
            self.performSegue(withIdentifier: "SFDialogToTeleop", sender: self)
        }
    }
}
