//
//  MatchModel.swift
//  2017 Scouting Collection
//
//  Created by Alex Tarng on 4/5/17.
//  Copyright © 2017 Paly Robotics. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class MatchModel: CoreData {
    
    static var matchList = [MatchModel]()
    
    var blue: [Int]
    var red: [Int]
    var key: String
    var matchNumber: Int
    var matchType: MatchType
    var matchIn: Int?
    
//    var scouted: Bool
    
    enum MatchType {
        case practice
        case qualifying
        case quarterFinal
        case semiFinal
        case final
        case unknown
        var string: String {
            switch self {
            case .practice: return "pr"
            case .qualifying: return "qm";
            case .quarterFinal: return "qf";
            case .semiFinal: return "sf";
            case .final: return "f";
            default: return "un"
            }
        }
    }
    
    init(keyV: String, blueAlliance: [Int], redAlliance: [Int]) {
        self.blue = blueAlliance
        self.red = redAlliance
        self.key = keyV
        let continuedString : String = key.components(separatedBy: "_")[1]
        let arrayOfCharc = Array(continuedString.characters)
        
        if arrayOfCharc[0] == Character("q"){
            if (arrayOfCharc[1] == Character("m")){
                matchType = MatchType.qualifying
                var matchNumberString: String = String(arrayOfCharc[2])
                if arrayOfCharc.count == 4{
                    matchNumberString += String(arrayOfCharc[3])
                }
                
                matchNumber = Int(matchNumberString)!
            }else{
                matchType = MatchType.quarterFinal
                let matchNumberString: String = String(arrayOfCharc[2])
                matchNumber = Int(matchNumberString)!
                let matchInString : String = String(arrayOfCharc[4])
                matchIn = Int(matchInString)
            }
        }else if arrayOfCharc[0] == Character("s"){
            matchType = MatchType.semiFinal
            let matchNumberString: String = String(arrayOfCharc[2])
            matchNumber = Int(matchNumberString)!
            let matchInString : String = String(arrayOfCharc[4])
            matchIn = Int(matchInString)
        }else if arrayOfCharc[0] == Character("f"){
            matchType = MatchType.final
            let matchNumberString : String = String(arrayOfCharc[1])
            matchNumber = Int(matchNumberString)!
            let matchInString : String = String(arrayOfCharc[3])
            matchIn = Int(matchInString)
        }else{
            matchType = MatchType.unknown
            matchNumber = 0
        }
        super.init(entityName: "Matches")
    }
    
    override init(_ managedObject: NSManagedObject) {
        let unarchivedData : NSData = managedObject.value(forKey: "data") as! NSData
        do {
            let dict: NSDictionary = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(unarchivedData) as! NSDictionary
            let blue = (dict.object(forKey: "blue") as! NSDictionary).object(forKey: "teams") as! [Int]
            let red = (dict.object(forKey: "red") as! NSDictionary).object(forKey: "teams") as! [Int]
            let key = dict.object(forKey: "key") as! String
            self.blue = blue
            self.red = red
            self.key = key
            let continuedString : String = key.components(separatedBy: "_")[1]
            let arrayOfCharc = Array(continuedString.characters)
            
            if arrayOfCharc[0] == Character("q"){
                if (arrayOfCharc[1] == Character("m")){
                    matchType = MatchType.qualifying
                    var matchNumberString: String = String(arrayOfCharc[2])
                    if arrayOfCharc.count == 4{
                        matchNumberString += String(arrayOfCharc[3])
                    }
                    
                    matchNumber = Int(matchNumberString)!
                }else{
                    matchType = MatchType.quarterFinal
                    let matchNumberString: String = String(arrayOfCharc[2])
                    matchNumber = Int(matchNumberString)!
                    let matchInString : String = String(arrayOfCharc[4])
                    matchIn = Int(matchInString)
                }
            }else if arrayOfCharc[0] == Character("s"){
                matchType = MatchType.semiFinal
                let matchNumberString: String = String(arrayOfCharc[2])
                matchNumber = Int(matchNumberString)!
                let matchInString : String = String(arrayOfCharc[4])
                matchIn = Int(matchInString)
            }else if arrayOfCharc[0] == Character("f"){
                matchType = MatchType.final
                let matchNumberString : String = String(arrayOfCharc[1])
                matchNumber = Int(matchNumberString)!
                let matchInString : String = String(arrayOfCharc[3])
                matchIn = Int(matchInString)
            }else{
                matchType = MatchType.unknown
                matchNumber = 0
            }
//            self.played = dict.object(forKey: "played") as! Bool
            super.init(managedObject)
            
        } catch {
            fatalError("core data fetch error")
        }
    }
    
    override func getJSON() -> NSDictionary {
        var blue = [Int]()
        for (team) in self.blue {
            blue.append(team)
        }
        var red = [Int]()
        for (team) in self.red {
            red.append(team)
        }
        return [
            "blue": [
                "teams": blue
            ],
            "red": [
                "teams": red
            ],
            "key": self.key,
//            "played": self.played
        ]
    }
    
    static func handleMatchJSON(_ callback: @escaping () -> Void,_ value: NSDictionary) -> Void {
        if (((value.value(forKey: "query") as! NSDictionary).value(forKey: "success"))! as! String == "yes") {
            for (match) in matchList {
                match.deleteFromCoreData()
            }
            matchList.removeAll()
            
            for (key, value) in (value.value(forKey: "query") as! NSDictionary).value(forKey: "matches") as! NSDictionary {
                let name = key as! String
                
                let payloadDict = value as! NSDictionary
                
                let blue = (payloadDict.object(forKey: "blue") as! [Int])
                let red = (payloadDict.object(forKey: "red") as! [Int])
                let match = MatchModel(keyV: name, blueAlliance: blue, redAlliance: red)
                match.saveToCoreData()
                matchList.append(match)
                
            }
            
            orderMatches()
        }
        else {
            print(value)
        }
        callback()
    }

    
    static func saveMatchesToCoreData() {
        for match in matchList {
            match.saveToCoreData()
        }
    }
    
    static func fetchMatchesFromCoreData(event: String) {
        //Clear list
        matchList.removeAll()
        
        //Getting stuff from the appDelegate
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDel.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Matches", in: managedContext)
        
        //Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entity
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            if (results.count > 0) {
                if let managedObjectResults = results as? [NSManagedObject] {
                    for i: NSManagedObject in managedObjectResults {
                        if (i.value(forKey: "event") as! String == DataModel.competition) {
                            matchList.append(MatchModel(i))
                        }
                    }
                    orderMatches()
                }
                
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }
    
    static func orderMatches() {
        var qualifyingMatches = [MatchModel]()
        var quarterFinals = [MatchModel]()
        var semiFinals = [MatchModel]()
        var finals = [MatchModel]()
        var unknowns = [MatchModel]()
        
        for matchToAssign : MatchModel in matchList {
            switch matchToAssign.matchType {
            case MatchModel.MatchType.qualifying:
                qualifyingMatches.append(matchToAssign)
            case MatchModel.MatchType.quarterFinal:
                quarterFinals.append(matchToAssign)
            case MatchModel.MatchType.semiFinal:
                semiFinals.append(matchToAssign)
            case MatchModel.MatchType.final:
                finals.append(matchToAssign)
            default:
                unknowns.append(matchToAssign)
            }
        }
        
        qualifyingMatches = qualifyingMatches.sorted{ return $0.matchNumber < $1.matchNumber}
        quarterFinals = quarterFinals.sorted{a,b in
            if a.matchNumber != b.matchNumber{
                return a.matchNumber < b.matchNumber
            }else{
                return a.matchIn! < b.matchIn!
            }
        }
        semiFinals = semiFinals.sorted{a,b in
            if a.matchNumber != b.matchNumber{
                return a.matchNumber < b.matchNumber
            }else{
                return a.matchIn! < b.matchIn!
            }
        }
        finals = finals.sorted{a,b in
            if a.matchNumber != b.matchNumber{
                return a.matchNumber < b.matchNumber
            }else{
                return a.matchIn! < b.matchIn!
            }
        }
        matchList = qualifyingMatches + quarterFinals + semiFinals + finals
        
    }
    
    func getTeam() -> Int? {
        let str = UIDevice.current.name
        let start = str.index(str.endIndex, offsetBy: -1)
        let end = str.index(str.endIndex, offsetBy: 0)
        let range = start..<end
        
        let num = str.substring(with: range)
//        print(num)
        switch (num) {
            case "1":
                return red[0]
            case "2":
                return red[1]
            case "3":
                return red[2]
            case "4":
                return blue[0]
            case "5":
                return blue[1]
            case "6":
                return blue[2]
            default:
                return nil
        }
    }

    func getData() -> DataModel? {
        var matchIn = -1
        if let m = self.matchIn {
            matchIn = m
        }
        for d in DataModel.dataList {
            let data = d.data
            if (data["event"] as! String == DataModel.competition && data["comp_level"] as! String == matchType.string && data["match_number"] as! Int == matchNumber && data["match_in"] as! Int == matchIn && data["scouting_team_number"] as? Int == self.getTeam()) {
                return d
            }
        }
        return nil
    }
}
