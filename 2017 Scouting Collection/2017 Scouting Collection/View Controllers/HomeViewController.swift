
//  HomeViewController.swift
//  2017 Scouting Collection
//
//  Created by Alex Tarng on 12/18/16.
//  Copyright © 2016 Paly Robotics. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class HomeViewController: ViewController, UIPickerViewDelegate, UIPickerViewDataSource{


    var pickerData = [String]()
    
    @IBOutlet weak var viewSavedMatches: UIButton!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var matchType: UILabel!
    @IBOutlet weak var matchNumber: UITextField!
    @IBOutlet weak var matchNumberOf: UITextField!
    @IBOutlet weak var matchNumberOfWidth: NSLayoutConstraint!
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet var startMatchButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let grey = UIColor.gray.cgColor
        
        name.layer.borderColor = grey
        name.layer.borderWidth = 0.5
        name.layer.cornerRadius = 5.0
        name.layer.masksToBounds = true
        
        matchType.layer.borderColor = grey
        matchType.layer.borderWidth = 0.5
        matchType.layer.cornerRadius = 5.0
        matchType.layer.masksToBounds = true
        
        matchNumber.layer.borderColor = grey
        matchNumber.layer.borderWidth = 0.5
        matchNumber.layer.cornerRadius = 5.0
        matchNumber.layer.masksToBounds = true
        
        matchNumberOf.layer.borderColor = grey
        matchNumberOf.layer.borderWidth = 0.5
        matchNumberOf.layer.cornerRadius = 5.0
        matchNumberOf.layer.masksToBounds = true
        
    }
    
    override func viewDidLoad() {
        //Check for Core Data and then show the viewSavedMatches
        
        let matchTypeTap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.matchTypePressed))
        matchType.addGestureRecognizer(matchTypeTap)
        matchType.isUserInteractionEnabled = true
        
        
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.hideStuff))
        view.addGestureRecognizer(hideTap)
        
        matchNumberOf.isUserInteractionEnabled = false
        matchNumberOfWidth.constant = 0
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        

        for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
    }
    
    func hideStuff(){
        view.endEditing(true)
        pickerView.isHidden = true
        startMatchButton.isHidden = false
    }
    func matchTypePressed(){
        print("matchTypePressed")
        view.endEditing(true)
        pickerData = ["Qualifying","Quarter Finals","Semi Finals", "Finals"]
        pickerView.reloadAllComponents()
        pickerView.isHidden = false
        startMatchButton.isHidden = true
        if matchType.text! != "Qualifying" && matchType.text! != "Match Type"{
            matchType.text = matchType.text
        }else{
            matchType.text = "Qualifying"
        }
        
        matchType.textColor = UIColor.black
        self.view.bringSubview(toFront: pickerView)
        
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return pickerData[row]
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView{
        
        print("Returning Custom label")
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        
        label?.font = UIFont(name: "Lato-Light", size: 22.0)!
        label?.text =  pickerData[row]
        label?.textAlignment = .center
        return label!
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        matchType.text = pickerData[row]
        
        pickerView.isHidden = true
        startMatchButton.isHidden = false
        if pickerData[row] != "Qualifying"{
            matchNumberOf.isUserInteractionEnabled = true
            matchNumberOfWidth.constant = 197
        }else{
            matchNumberOf.isUserInteractionEnabled = false
            matchNumberOfWidth.constant = 0
            matchNumberOf.text = ""
        }
    }
    @IBAction func startMatchPressed(_ sender: Any) {

        if name.text == " " || matchType.text == "Match Type" || matchNumber.text == "" || (matchNumberOf.text == "" && matchNumberOfWidth.constant > 0){
            
            let alertController = UIAlertController(title: "Complete Form", message: "Please fill everything in. Thanks!", preferredStyle: .alert)
            
            self.present(alertController, animated: true, completion:nil)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            }
            
            alertController.addAction(OKAction)
            
            return
        }
        if  (matchNumberOfWidth.constant > 0){
            if Int(matchNumberOf.text!)! > 4{
                let alertController = UIAlertController(title: "Invalid Match Number", message: "There can only be 4 matches played in the knockout stages", preferredStyle: .alert)
                
                self.present(alertController, animated: true, completion:nil)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                }
                
                alertController.addAction(OKAction)
                
                return
            }
        }

        
        performSegue(withIdentifier: "startMatch", sender: self)

    }
    
    
    
    

}
