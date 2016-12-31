//
//  EndgameViewController.swift
//  2017 Scouting Collection
//
//  Created by Alex Tarng on 12/24/16.
//  Copyright © 2016 Paly Robotics. All rights reserved.
//

import Foundation
import UIKit

class EndgameViewController: ViewController, UITextViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var activeField: UITextView!
    
    @IBAction func toggleButtonPressed(_ sender: ToggleButton) {
        switch(sender.tag) {
        case 0:
            //Challenge
            print("Challenge")
            Data.currentMatch!.challenge = sender.toggleState
            break
        case 1:
            //Scale
            print("Scale")
            Data.currentMatch!.scale = sender.toggleState
            break
        default:
            //wat
            break
        }
    }
    
    @IBAction func finishButtonPressed(_ sender: Any) {
        Data.currentMatch!.notes = activeField.text
        performSegue(withIdentifier: "endgameToViewData", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activeField.delegate = self
        self.hideKeyboardWhenTappedAround()
        print("hello?")
    }
    
    //Text Field scrolling
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
        print("wai")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deregisterFromKeyboardNotifications()
    }
    
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
    
    var keyboardSize: CGSize?
    
    func textViewDidChange(_ textView: UITextView) {
        var caret = activeField.caretRect(for: activeField.selectedTextRange!.start)
        let keyboardTopBorder = activeField.bounds.size.height - self.keyboardSize!.height
        
        if caret.origin.y > keyboardTopBorder {
            caret.origin.y += self.scrollView.frame.origin.y
            scrollView.scrollRectToVisible(caret, animated: true)
        }
    }
    
    func keyboardWasShown(notification: NSNotification){
        self.scrollView.isScrollEnabled = true
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        self.keyboardSize = keyboardSize
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var caret = activeField.caretRect(for: activeField.selectedTextRange!.start)
        let keyboardTopBorder = activeField.bounds.size.height - self.keyboardSize!.height

        if caret.origin.y > keyboardTopBorder {
            caret.origin.y += self.scrollView.frame.origin.y
            scrollView.scrollRectToVisible(caret, animated: true)
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
    
    //Limit Textview # lines
    func sizeOfString (string: String, constrainedToWidth width: Double, font: UIFont) -> CGSize {
        return (string as NSString).boundingRect(with: CGSize(width: width, height: DBL_MAX),
                                                         options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                         attributes: [NSFontAttributeName: font],
                                                         context: nil).size
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        var textWidth = UIEdgeInsetsInsetRect(textView.frame, textView.textContainerInset).width
        textWidth -= 2.0 * textView.textContainer.lineFragmentPadding;
        
        let boundingRect = sizeOfString(string: newText, constrainedToWidth: Double(textWidth), font: textView.font!)
        let numberOfLines = boundingRect.height / textView.font!.lineHeight;
        
        return numberOfLines <= 17;
    }
}
