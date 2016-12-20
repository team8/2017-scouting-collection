
//  File.swift
//  2017 Scouting Collection
//
//  Created by Alex Tarng on 12/18/16.
//  Copyright © 2016 Paly Robotics. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: ViewController, UITableViewDataSource, UITableViewDelegate {
    //    @IBOutlet weak var myButton : UIButton!
    //    @IBOutlet weak var myTextField : UITextField!
    //
    //    @IBAction func myButtonAction(sender: id)
    
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var dataTable: UITableView!
    
    @IBAction func homeUnwind(unwindSegue: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        dataTable.dataSource = self
        dataTable.delegate = self
        dataTable.register(TableViewCell.classForCoder(), forCellReuseIdentifier: "DataCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Gradient
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame = self.view.frame
        let color1 = UIColor(colorLiteralRed: 34/255, green: 139/255, blue: 34/255, alpha: 1).cgColor
        let color2 = UIColor(colorLiteralRed: 17/255, green: 38/255, blue: 11/255, alpha: 1).cgColor
        gradient.colors = [color1, color2] //Or any colors
        self.view.layer.insertSublayer(gradient, at: 0)
        
        //Borders
        newButton.layer.borderWidth = 1
        newButton.layer.borderColor = UIColor.white.cgColor
        
        
    }
    
    
    //White status bar
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent;
    }
    
    //Fill table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempList = ["Team 8, Q1", "Team 254, Q2", "Team 971, Q3", "Team 1678, Q4", "Team 254, Q2", "Team 971, Q3", "Team 1678, Q4", "Team 254, Q2", "Team 971, Q3", "Team 1678, Q4", "Team 254, Q2", "Team 971, Q3", "Team 1678, Q4", "Team 254, Q2", "Team 971, Q3", "Team 1678, Q4", "Team 254, Q2", "Team 971, Q3", "Team 1678, Q4"]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! TableViewCell
        cell.textLabel?.text = tempList[indexPath.row]
//        cell.layer.borderWidth = 1
//        cell.layer.borderColor = UIColor.white.cgColor
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.font = UIFont(name:"Lato", size:20)
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.layer.borderWidth = 2
        cell.textLabel?.layer.borderColor = UIColor.white.cgColor
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        print("ym")
        return cell
    }
    
    //When table cell selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        cell.textLabel?.textColor = UIColor.lightText
//
//        if let dataToSend = cell.student {
//            performSegue(withIdentifier: "DestinationView", sender: dataToSend)
//        }
        print("waddup")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
}
