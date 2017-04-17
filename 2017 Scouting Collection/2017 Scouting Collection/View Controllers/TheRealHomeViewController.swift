
//  TheRealHomeViewController.swift
//  2017 Scouting Collection
//
//  Created by Alex Tarng on 12/18/16.
//  Copyright © 2016 Paly Robotics. All rights reserved.
//

import Foundation
import UIKit

class TheRealHomeViewController: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func realHomeUnwind(unwindSegue: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        MatchModel.fetchMatchesFromCoreData(event: DataModel.competition)
        DataModel.fetchDataFromCoreData(event: DataModel.competition)
        tableView.reloadData()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func newMatchPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "homeToPrematch", sender: nil)
    }
    
    @IBAction func refresh(_ sender: Any) {
        ServerInteractor.getMatches(MatchModel.handleMatchJSON, callback2: fetchComplete, key: DataModel.competition)
    }
    
    func fetchComplete() {
        tableView.reloadData()
        print("fetch complete")
        print(MatchModel.matchList)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        
        var practice = [DataModel]()
        
        for d in DataModel.dataList {
//            print(d.matchType.string)
            if d.data["comp_level"] as! String == "pr" {
                practice.append(d)
            }
        }
        
        var compLevel: String
        var matchNum: String
        var matchIn = "-1"
        var teamNumber: String
        var data: DataModel?
        
        if indexPath.row < practice.count {
            data = practice[indexPath.row]
            compLevel = data!.data["comp_level"] as! String
            matchNum = String(data!.data["match_number"] as! Int)
            teamNumber = String(data!.data["scouting_team_number"] as! Int)
        } else {
            let match = MatchModel.matchList[indexPath.row - practice.count]
            compLevel = match.matchType.string
            matchNum = String(match.matchNumber)
            matchIn = "-1"
            if let m = match.matchIn {
                matchIn = String(m)
            }
            teamNumber = String(match.getTeam()!)
            data = match.getData()
        }
        
        
        let event = DataModel.competition
        
        if let d = data {
            let csv = d.CSV()
            let vars = csv.components(separatedBy: ",")
            let name = vars[0]
            if (matchIn == "-1") {
                cell.textLabel!.text = "[Scouted] " + compLevel + matchNum + ", " + name + ", Team " + teamNumber + ", " + event
            } else {
                cell.textLabel!.text = "[Scouted] " + compLevel + matchNum + "m" + matchIn + ", " + name + ", Team " + teamNumber + ", " + event
            }

        } else {
            if (matchIn == "-1") {
                cell.textLabel!.text = compLevel + matchNum + ", Team " + teamNumber + ", " + event
            } else {
                cell.textLabel!.text = compLevel + matchNum + "m" + matchIn + ", Team " + teamNumber +  ", " + event
            }
        }
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var practice = [DataModel]()
        
        for d in DataModel.dataList {
            //            print(d.matchType.string)
            if d.data["comp_level"] as! String == "pr" {
                practice.append(d)
            }
        }
        
        if indexPath.row < practice.count {
            let data = practice[indexPath.row]
//            let csv = data.CSV()
            self.performSegue(withIdentifier: "homeToQR", sender: data)
        } else {
            let match = MatchModel.matchList[indexPath.row - practice.count]
            if let data = match.getData() {
//                let csv = data.CSV()
                self.performSegue(withIdentifier: "homeToQR", sender: data)
            } else {
                self.performSegue(withIdentifier: "homeToPrematch", sender: match)
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "homeToQR") {
            let secondViewController = segue.destination as! QRCodeViewController
            let data = sender as! DataModel
            secondViewController.data = data
        } else if (segue.identifier == "homeToPrematch") {
            let secondViewController = segue.destination as! HomeViewController
            if let match = sender as? MatchModel {
                secondViewController.match = match
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var practice = [DataModel]()
        
        for d in DataModel.dataList {
            //            print(d.matchType.string)
            if d.data["comp_level"] as! String == "pr" {
                practice.append(d)
            }
        }
        
        return MatchModel.matchList.count + practice.count
    }
}
