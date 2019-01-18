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
    
    init(username: String, score: String) {
        self.username = username
        self.score = score
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        score = snapshotValue["score"] as! String
        username = snapshotValue["username"] as! String
    }
    
    func toAnyObject() -> Any {
        return [
            "score": score,
            "username": username
        ]
    }
}
