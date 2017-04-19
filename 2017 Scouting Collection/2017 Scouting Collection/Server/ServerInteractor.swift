//
//  ServerInteractor.swift
//  2017 Scouting Collection
//
//  Created by Alex Tarng on 4/5/17.
//  Copyright © 2017 Paly Robotics. All rights reserved.
//

import Foundation
import Alamofire

class ServerInteractor {
    
    static let AUTH_TOKEN = "roebling"
    static let SERVER_ADDRESS = "http://server.palyrobotics.com:5000"
    
    static func getMatches(_ callback: @escaping (_ callback: @escaping () -> Void, NSDictionary) -> Void, callback2: @escaping () -> Void, key : String) -> Void {
        print("[Server Interactor] Retrieving matches for event " + key)
        Alamofire.request(SERVER_ADDRESS + "/" + AUTH_TOKEN + "/match/" + key, headers: nil)
            .responseJSON { response in
                if let JSON = response.result.value {
                    print("[Server Interactor] Successfully retrieved matches for event " + key)
                    print("JSON: \(JSON)")
                    let rawVal = JSON as! NSDictionary
                    callback(callback2, rawVal)
                }
                else if let status = response.result.error?._code {
                    print(response)
                    switch(status){
                    case -1009:
                        print("[Server Interactor] Error retrieving matches for event " + key + ": The Internet connection appears to be offline.")
                    default:
                        print("[Server Interactor] Error parsing server response, please make sure the server is running.")
                    }
                    callback(callback2, ["query": ["success": "no"]])
                } else {
                    print(response)
                    print("[Server Interactor] Error parsing server response, please make sure the server is running.")
                    callback(callback2, ["query": ["success": "no"]])
                }
        }
    }

}
