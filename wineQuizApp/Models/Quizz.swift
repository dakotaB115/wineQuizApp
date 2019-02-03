//
//  Quizz.swift
//  wineQuizApp
//
//  Created by Dakota Brown on 1/18/19.
//  Copyright © 2019 Dakota Brown. All rights reserved.
//

import Foundation
import Firebase

struct Quizz {
    let quizz: String
    
    init(quizz: String) {
        self.quizz = quizz
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        quizz = snapshotValue["quizz"] as! String
        Database.database().reference().child("Regions").child(quizz).observe(.value) { (snapshot: DataSnapshot!) in
            numberOfUsers = Int(snapshot.childrenCount) - 1
            print(numberOfUsers)
        }
        print(numberOfUsers)
        
    }
    
    func toAnyObject() -> Any {
        return [
            "quizz": quizz,
        ]
    }
}
