
//  HomeViewController.swift
//  2017 Scouting Collection
//
//  Created by Alex Tarng on 12/18/16.
//  Copyright © 2016 Paly Robotics. All rights reserved.
//

import Foundation
import UIKit
import CoreData

//class HomeViewController: ViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
class HomeViewController: ViewController, UITextFieldDelegate {



    var pickerData = [String]()
    
    var match: MatchModel?
    
//    @IBOutlet weak var viewSavedMatches: UIButton!
    @IBOutlet weak var matchLabel: UILabel!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var yourTeamNumber: UITextField!
//    @IBOutlet weak var matchType: UILabel!
    @IBOutlet weak var matchNumber: UITextField!
    @IBOutlet weak var matchNumberHeight: NSLayoutConstraint!
//    @IBOutlet weak var matchNumberOf: UITextField!
//    @IBOutlet weak var matchNumberOfWidth: NSLayoutConstraint!
    @IBOutlet weak var scoutingTeamNumber: UITextField!
    @IBOutlet weak var scoutingTeamNumberHeight: NSLayoutConstraint!
    
//    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet var startMatchButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let grey = UIColor.gray.cgColor
        
        
        name.layer.borderColor = grey
        name.layer.borderWidth = 0.5
        name.layer.cornerRadius = 5.0
        name.layer.masksToBounds = true
        
        yourTeamNumber.layer.borderColor = grey
        yourTeamNumber.layer.borderWidth = 0.5
        yourTeamNumber.layer.cornerRadius = 5.0
        yourTeamNumber.layer.masksToBounds = true
        
//        matchType.layer.borderColor = grey
//        matchType.layer.borderWidth = 0.5
//        matchType.layer.cornerRadius = 5.0
//        matchType.layer.masksToBounds = true
        
        matchNumber.layer.borderColor = grey
        matchNumber.layer.borderWidth = 0.5
        matchNumber.layer.cornerRadius = 5.0
        matchNumber.layer.masksToBounds = true
        
//        matchNumberOf.layer.borderColor = grey
//        matchNumberOf.layer.borderWidth = 0.5
//        matchNumberOf.layer.cornerRadius = 5.0
//        matchNumberOf.layer.masksToBounds = true
        
        scoutingTeamNumber.layer.borderColor = grey
        scoutingTeamNumber.layer.borderWidth = 0.5
        scoutingTeamNumber.layer.cornerRadius = 5.0
        scoutingTeamNumber.layer.masksToBounds = true
        
        if self.match != nil {
            matchNumberHeight.constant = 0
            scoutingTeamNumberHeight.constant = 0
            if let m = self.match!.matchIn {
                let matchIn = String(m)
                matchLabel.text = self.match!.matchType.string + String(self.match!.matchNumber) + "m" + matchIn  + ", Team " + String(self.match!.getTeam()!)
            } else {
                matchLabel.text = self.match!.matchType.string + String(self.match!.matchNumber) + ", Team " + String(self.match!.getTeam()!)
            }
        }
    }
    
    override func viewDidLoad() {
        //Check for Core Data and then show the viewSavedMatches
        
//        let matchTypeTap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.matchTypePressed))
//        matchType.addGestureRecognizer(matchTypeTap)
//        matchType.isUserInteractionEnabled = true
        
        
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.hideStuff))
        view.addGestureRecognizer(hideTap)
        
//        matchNumberOf.isUserInteractionEnabled = false
//        matchNumberOfWidth.constant = 0
        
//        pickerView.dataSource = self
//        pickerView.delegate = self
        
        yourTeamNumber.delegate = self
        matchNumber.delegate = self
//        matchNumberOf.delegate = self
        scoutingTeamNumber.delegate = self
        

//        for family: String in UIFont.familyNames
//        {
//            print("\(family)")
//            for names: String in UIFont.fontNames(forFamilyName: family)
//            {
//                print("== \(names)")
//            }
//        }
    }
    
    //Restrict text fields to numbers only
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //        if !(textField == self.name){
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
        //        }
        //        return true
    }
    
    func hideStuff(){
        view.endEditing(true)
//        pickerView.isHidden = true
//        startMatchButton.isHidden = false
    }
//    func matchTypePressed(){
//        print("matchTypePressed")
//        view.endEditing(true)
//        pickerData = ["Qualifying","Quarter Finals","Semi Finals", "Finals"]
//        pickerView.reloadAllComponents()
//        pickerView.isHidden = false
//        startMatchButton.isHidden = true
//        if matchType.text! != "Qualifying" && matchType.text! != "Match Type"{
//            matchType.text = matchType.text
//        }else{
//            matchType.text = "Qualifying"
//        }
//        
//        matchType.textColor = UIColor.black
//        self.view.bringSubview(toFront: pickerView)
//        
//    }
    
    
//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    @available(iOS 2.0, *)
//    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
    
    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pickerData.count
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
//        return pickerData[row]
//    }
//    
//    
//    
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView{
//        
//        print("Returning Custom label")
//        var label = view as! UILabel!
//        if label == nil {
//            label = UILabel()
//        }
//        
//        label?.font = UIFont(name: "Lato-Light", size: 22.0)!
//        label?.text =  pickerData[row]
//        label?.textAlignment = .center
//        return label!
//        
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        matchType.text = pickerData[row]
//        
//        pickerView.isHidden = true
//        startMatchButton.isHidden = false
//        if pickerData[row] != "Qualifying"{
//            matchNumberOf.isUserInteractionEnabled = true
//            matchNumberOfWidth.constant = 197
//        }else{
//            matchNumberOf.isUserInteractionEnabled = false
//            matchNumberOfWidth.constant = 0
//            matchNumberOf.text = ""
//        }
//    }
    @IBAction func startMatchPressed(_ sender: Any) {

//        if name.text == " " || matchType.text == "Match Type" || matchNumber.text == "" || (matchNumberOf.text == "" && matchNumberOfWidth.constant > 0) || scoutingTeamNumber.text == ""{
        if self.name.text == " " || yourTeamNumber.text == "" || (matchNumber.text == "" && matchNumberHeight.constant != 0) || (scoutingTeamNumber.text == "" && scoutingTeamNumberHeight.constant != 0){

            
            let alertController = UIAlertController(title: "Complete Form", message: "Please fill everything in. Thanks!", preferredStyle: .alert)
            
            self.present(alertController, animated: true, completion:nil)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                
            }
            
            alertController.addAction(OKAction)
            
            return
        }
//        if  (matchNumberOfWidth.constant > 0){
//            if Int(matchNumberOf.text!)! > 4{
//                let alertController = UIAlertController(title: "Invalid Match Number", message: "There can only be 4 matches played in the elimination stages", preferredStyle: .alert)
//                
//                self.present(alertController, animated: true, completion:nil)
//                
//                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
//                }
//                
//                alertController.addAction(OKAction)
//                
//                return
//            }
//        }
//        var matchTypeType : MatchModel.MatchType = MatchModel.MatchType.Unknown
//        switch matchType.text! {
//        case "Qualifying":
//            matchTypeType = MatchModel.MatchType.Qualifying
//            break
//        case "Quarter Finals":
//            matchTypeType = MatchModel.MatchType.QuarterFinals
//            break
//        case "Semi Finals":
//            matchTypeType = MatchModel.MatchType.SemiFinals
//        case "Finals":
//            matchTypeType = MatchModel.MatchType.Finals
//        default:
//            break
//        }
        var name = ""
        let names = self.name.text!.components(separatedBy: ",")
        for n in names {
            name += n
        }
        DataModel.currentData = DataModel()
        DataModel.currentData!.scouterName = name + yourTeamNumber.text!
//        DataModel.currentData!.matchType = matchTypeType
        if self.match == nil {
            DataModel.currentData!.matchNumber = Int(matchNumber.text!)!
            DataModel.currentData!.scoutingTeamNumber = Int(scoutingTeamNumber.text!)!
            DataModel.currentData!.matchType = MatchModel.MatchType.practice
        } else {
            DataModel.currentData!.matchType = self.match!.matchType
            DataModel.currentData!.scoutingTeamNumber = self.match!.getTeam()!
            DataModel.currentData!.matchNumber = self.match!.matchNumber
            if DataModel.currentData!.matchType != MatchModel.MatchType.qualifying {
                DataModel.currentData!.matchNumberOf = self.match!.matchIn
            }
        }
        performSegue(withIdentifier: "startMatch", sender: self)

    }
    
    @IBAction func homeUnwind(unwindSegue: UIStoryboardSegue) {
        
    }
    
    
    

}
