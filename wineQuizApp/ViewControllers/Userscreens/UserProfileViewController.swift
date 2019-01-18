//
//  UserProfileViewController.swift
//  wineQuizApp
//
//  Created by Dakota Brown on 1/15/19.
//  Copyright © 2019 Dakota Brown. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UIViewController {

    @IBOutlet weak var welcomeUserLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var percentCorrectLabel: UILabel!
    @IBOutlet weak var numberOfQuizzesTakenLabel: UILabel!
    
    let userID = Auth.auth().currentUser!.uid
    var ref: DatabaseReference!
    
    func userData() {
        ref?.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let usernameSnap = value?["username"] as? String ?? ""
            let emailSnap = value?["email"] as? String ?? ""
            let numberOfQuizzesSnap = value?["numberOfQuizzesTaken"] as? Int ?? 0
            
            self.welcomeUserLabel.text = ("Welcome back \(usernameSnap)!")
            self.usernameLabel.text = usernameSnap
            self.emailLabel.text = emailSnap
            self.numberOfQuizzesTakenLabel.text = String(numberOfQuizzesSnap)
        })
        ref?.child("users").child(userID).child("QuizScores").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let percentSnap = value?["totalPercent"] as? Int ?? 0
            
            self.percentCorrectLabel.text = ("\(percentSnap)%")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        userData()
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("logged out")
            self.performSegue(withIdentifier: "logout", sender: self)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}
