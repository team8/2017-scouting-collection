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
    
    var parentValue: Int?
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        //someone please make my code better -at
        switch(parentValue!){
        case 0:
            print("Low goal")
            switch(sender.tag){
            case 0:
                print("+ Success")
                Data.currentMatch?.autoLowGoalSuccess += 1
                break
            case 1:
                print("- Success")
                Data.currentMatch?.autoLowGoalSuccess -= 1
                break
            case 2:
                print("+ Failure")
                Data.currentMatch?.autoLowGoalFailure += 1
                break
            case 3:
                print("- Failure")
                Data.currentMatch?.autoLowGoalFailure -= 1
                break
            default:
                print("wat")
                break
            }
            break
        case 1:
            print("High goal")
            switch(sender.tag){
            case 0:
                print("+ Success")
                Data.currentMatch?.autoHighGoalSuccess += 1
                break
            case 1:
                print("- Success")
                Data.currentMatch?.autoHighGoalSuccess -= 1
                break
            case 2:
                print("+ Failure")
                Data.currentMatch?.autoHighGoalFailure += 1
                break
            case 3:
                print("- Failure")
                Data.currentMatch?.autoHighGoalFailure -= 1
                break
            default:
                print("wat")
                break
            }
            break
        case 2:
            print("Low bar")
            switch(sender.tag){
            case 0:
                print("+ Success")
                Data.currentMatch?.autoLowBarSuccess += 1
                break
            case 1:
                print("- Success")
                Data.currentMatch?.autoLowBarSuccess -= 1
                break
            case 2:
                print("+ Failure")
                Data.currentMatch?.autoLowBarFailure += 1
                break
            case 3:
                print("- Failure")
                Data.currentMatch?.autoLowBarFailure -= 1
                break
            default:
                print("wat")
                break
            }
            break
        case 3:
            print("Defense 1")
            switch(sender.tag){
            case 0:
                print("+ Success")
                Data.currentMatch?.autoDef1Success += 1
                break
            case 1:
                print("- Success")
                Data.currentMatch?.autoDef1Success -= 1
                break
            case 2:
                print("+ Failure")
                Data.currentMatch?.autoDef1Failure += 1
                break
            case 3:
                print("- Failure")
                Data.currentMatch?.autoDef1Failure -= 1
                break
            default:
                print("wat")
                break
            }
            break
        case 4:
            print("Defense 2")
            switch(sender.tag){
            case 0:
                print("+ Success")
                Data.currentMatch?.autoDef2Success += 1
                break
            case 1:
                print("- Success")
                Data.currentMatch?.autoDef2Success -= 1
                break
            case 2:
                print("+ Failure")
                Data.currentMatch?.autoDef2Failure += 1
                break
            case 3:
                print("- Failure")
                Data.currentMatch?.autoDef2Failure -= 1
                break
            default:
                print("wat")
                break
            }
            break
        case 5:
            print("Defense 3")
            switch(sender.tag){
            case 0:
                print("+ Success")
                Data.currentMatch?.autoDef3Success += 1
                break
            case 1:
                print("- Success")
                Data.currentMatch?.autoDef3Success -= 1
                break
            case 2:
                print("+ Failure")
                Data.currentMatch?.autoDef3Failure += 1
                break
            case 3:
                print("- Failure")
                Data.currentMatch?.autoDef3Failure -= 1
                break
            default:
                print("wat")
                break
            }

            break
        case 6:
            print("Defense 4")
            switch(sender.tag){
            case 0:
                print("+ Success")
                Data.currentMatch?.autoDef4Success += 1
                break
            case 1:
                print("- Success")
                Data.currentMatch?.autoDef4Success -= 1
                break
            case 2:
                print("+ Failure")
                Data.currentMatch?.autoDef4Failure += 1
                break
            case 3:
                print("- Failure")
                Data.currentMatch?.autoDef4Failure -= 1
                break
            default:
                print("wat")
                break
            }
            break
        default:
            print("wat")
            break
        }
        self.performSegue(withIdentifier: "SFDialogToAuto", sender: self)
    }
}
