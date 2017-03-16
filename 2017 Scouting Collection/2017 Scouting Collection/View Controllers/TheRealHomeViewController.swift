
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
        
        DataModel.fetchCSVsFromCoreData()
        tableView.reloadData()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        
        let csv = DataModel.storedCSVs[indexPath.row]
        let vars = csv.components(separatedBy: ",")
        let name = vars[0]
        let compLevel = vars[1]
        let matchNum = vars[2]
        let matchIn = vars[3]
        let teamNumber = vars[4]
        let event = vars[vars.count - 1]
        
        if (matchIn == "-1") {
            cell.textLabel!.text = name + ", Team " + teamNumber + ", " + compLevel + matchNum + ", " + event
        } else {
            cell.textLabel!.text = name + ", Team " + teamNumber + ", " + compLevel + matchNum + "m" + matchIn + ", " + event
        }
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "homeToQR", sender: DataModel.storedCSVs[indexPath.row])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "homeToQR") {
            let secondViewController = segue.destination as! QRCodeViewController
            let csv = sender as! String
            secondViewController.TextTOQRCode = csv
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.storedCSVs.count
    }
}
