
//  PrematchViewController.swift
//  2017 Scouting Collection
//
//  Created by Alex Tarng on 12/18/16.
//  Copyright © 2016 Paly Robotics. All rights reserved.
//

import Foundation
import UIKit

class PrematchViewController: ViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var startButton: Button!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var teamNumber: UITextField!
    @IBOutlet weak var matchNumber: UITextField!
    @IBOutlet weak var activeField: UITextField!
    @IBAction func prematchUnwind(unwindSegue: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activeField.delegate = self
        self.teamNumber.delegate = self
        self.matchNumber.delegate = self
        self.hideKeyboardWhenTappedAround()
        self.scrollView.isScrollEnabled = false
        startButton.disable()
        name.addTarget(self, action: #selector(checkFields), for: .editingDidEnd)
        teamNumber.addTarget(self, action: #selector(checkFields), for: .editingDidEnd)
        matchNumber.addTarget(self, action: #selector(checkFields), for: .editingDidEnd)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deregisterFromKeyboardNotifications()
    }
    
    //Check if all fields are filled
    func checkFields(sender: UITextField) {
//        sender.text = sender.text?.stringByTrimmingCharactersInSet(.whitespaceCharacterSet())
        if(!(name.text?.isEmpty)! && !(teamNumber.text?.isEmpty)! && !(matchNumber.text?.isEmpty)!) {
            startButton.enable()
        } else {
            startButton.disable()
        }
    }
    
    //Start button pressed
    @IBAction func startButtonPressed(_ sender: Any) {
        DataModel.currentMatch!.name = self.name.text!
        DataModel.currentMatch!.teamNumber = Int(self.teamNumber.text!)!
        DataModel.currentMatch!.matchNumber = Int(self.matchNumber.text!)!
        performSegue(withIdentifier: "prematchToAuto", sender: nil)
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
    
    //Text Field scrolling
    func registerForKeyboardNotifications(){
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification){
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scrollView.isScrollEnabled = true
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.activeField {
            if (!aRect.contains(activeField.frame.origin)){
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification){
        //Once keyboard disappears, restore original positions
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollView.isScrollEnabled = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        activeField = nil
    }
}
