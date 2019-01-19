//
//  Contacts.swift
//  wineQuizApp
//
//  Created by Dakota Brown on 1/18/19.
//  Copyright © 2019 Dakota Brown. All rights reserved.
//

import Foundation
import Firebase

struct Contact {
    let username: String
    let email: String
    let userID: String
    
    init(username: String, email: String, userId: String) {
        self.username = username
        self.email = email
        self.userID = userId
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        email = snapshotValue["email"] as! String
        username = snapshotValue["username"] as! String
        userID = snapshotValue["userID"] as! String
    }
    
    func toAnyObject() -> Any {
        return [
            "email": email,
            "username": username,
            "userID": userID
        ]
    }
}
