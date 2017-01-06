
//  HomeViewController.swift
//  2017 Scouting Collection
//
//  Created by Alex Tarng on 12/18/16.
//  Copyright © 2016 Paly Robotics. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class HomeViewController: ViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var dataTable: UITableView!
    
    @IBAction func homeUnwind(unwindSegue: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        dataTable.dataSource = self
        dataTable.delegate = self
        dataTable.register(TableViewCell.classForCoder(), forCellReuseIdentifier: "DataCell")
    }
    
    var testList: [NSManagedObject]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataModel.reloadCoreData()
    }
    
    @IBAction func newMatchPressed(_ sender: UIButton) {
        DataModel.currentMatch = DataModel()
    }
    
    //Fill table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let tempList = ["Team 8, Q1", "Team 254, Q2", "Team 971, Q3", "Team 1678, Q4", "Team 254, Q2", "Team 971, Q3", "Team 1678, Q4", "Team 254, Q2", "Team 971, Q3", "Team 1678, Q4", "Team 254, Q2", "Team 971, Q3", "Team 1678, Q4", "Team 254, Q2", "Team 971, Q3", "Team 1678, Q4", "Team 254, Q2", "Team 971, Q3", "Team 1678, Q4"]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! TableViewCell
        cell.textLabel?.text = DataModel.matches[indexPath.row].name
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.font = UIFont(name:"Lato", size:20)
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.layer.borderWidth = 2
        cell.textLabel?.layer.borderColor = UIColor.white.cgColor
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    //When table cell selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
//
//        if let dataToSend = cell.student {
//            performSegue(withIdentifier: "DestinationView", sender: dataToSend)
//        }
//        UIView.animate(withDuration: 0.1, animations: { () -> Void in
//            cell.textLabel?.backgroundColor = UIColor.clear
//        })
        UIView.animateKeyframes(withDuration: 0.35 /*Total*/, delay:0.0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration:0.10, animations:{
                cell.textLabel?.backgroundColor = UIColor.white
            })
            UIView.addKeyframe(withRelativeStartTime: 0.10, relativeDuration:0.25, animations:{
                cell.textLabel?.backgroundColor = UIColor.clear
            })
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.matches.count
    }
}
