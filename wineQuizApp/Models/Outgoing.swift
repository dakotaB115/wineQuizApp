//
//  Outgoing.swift
//  wineQuizApp
//
//  Created by Dakota Brown on 2/2/19.
//  Copyright © 2019 Dakota Brown. All rights reserved.
//

import Foundation
import Firebase

struct Outgoing {
    let username: String
    let message: String
    
    init(username: String, message: String) {
        self.username = username
        self.message = message
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        message = snapshotValue[outgoingMessages] as! String
        username = snapshotValue["username"] as! String
    }
    
    func toAnyObject() -> Any {
        return [
            outgoingMessages: message,
            "username": username,
        ]
    }
}
