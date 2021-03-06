//
//  Leaderboard.swift
//  wineQuizApp
//
//  Created by Dakota Brown on 1/17/19.
//  Copyright © 2019 Dakota Brown. All rights reserved.
//

import Foundation
import Firebase

struct Leaderboard {
    let username: String
    let score: String
    let number: Int
    
    init(username: String, score: String, number: Int) {
        self.username = username
        self.score = score
        self.number = number
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        score = snapshotValue["score"] as! String
        username = snapshotValue["username"] as! String
        number = snapshotValue["number"] as! Int
    }
    
    func toAnyObject() -> Any {
        return [
            "score": score,
            "username": username,
            "number": number
        ]
    }
}
