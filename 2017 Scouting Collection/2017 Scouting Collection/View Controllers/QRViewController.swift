//
//  QRViewController.swift
//  2017 Scouting Collection
//
//  Created by Alex Tarng on 12/24/16.
//  Copyright © 2016 Paly Robotics. All rights reserved.
//

import Foundation
import UIKit
import QRCode

class QRCodeViewController : ViewController {
    
    @IBOutlet weak var qrC: UIImageView?
    
    var TextTOQRCode : String = ""
    
    override func viewDidLoad() {
        
        TextTOQRCode = "QR Code String Goes Here"
        
        var qrCode = QRCode(TextTOQRCode)
        qrCode?.size = CGSize(width: 300, height: 300)
        
        qrC?.image = qrCode?.image
    }
    
    
}
