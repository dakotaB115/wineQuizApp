//
//  CreateUserViewController.swift
//  wineQuizApp
//
//  Created by Dakota Brown on 1/15/19.
//  Copyright © 2019 Dakota Brown. All rights reserved.
//

import UIKit
import Firebase

class CreateUserViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var confirmEmailTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    
    var email: String = ""
    var password: String = ""
    var ref: DatabaseReference!
    var newUser: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.text = ""
        usernameTextField.underlined()
        emailTextfield.text = ""
        emailTextfield.underlined()
        confirmEmailTextfield.text = ""
        confirmEmailTextfield.underlined()
        passwordTextField.text = ""
        passwordTextField.underlined()
        confirmPasswordText.text = ""
        confirmPasswordText.underlined()
        
        //grabs a database reference so we can write user data to it
        ref = Database.database().reference()
        ref.child("users").observe(.value) { (snapshot: DataSnapshot!) in
            self.newUser = Int(snapshot.childrenCount)
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("logged out")
            self.performSegue(withIdentifier: "logout", sender: self)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    private var authUser : User? {
        return Auth.auth().currentUser
    }
    
    public func sendVerificationMail() {
        if self.authUser != nil && !self.authUser!.isEmailVerified {
            self.authUser!.sendEmailVerification(completion: { (error) in
                // Notify the user that the mail has sent or couldn't because of an error.
                self.displayError(title: "Sent verification email", message: "Please check your email")
            })
        }
        else {
            // Either the user is not available, or the user is already verified.
        }
    }
    //displays an error on screen depending on when it's called
    func displayError(title: String, message: String) {
        let title = title
        let message = message
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            self.dismiss(animated: true)
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
    //end
    
    @IBAction func registerUserButtonPressed(_ sender: Any) {
        
        //checks to see if the textfield is empty for not and displays an error if that field isn't filled out
        guard let username = usernameTextField.text, !username.isEmpty else {
            displayError(title: "Missing an username", message: "Please enter an username.")
            return
        }
        
        guard let userEmail = emailTextfield.text, !userEmail.isEmpty else {
            displayError(title: "Missing an email", message: "Please enter an email.")
            return
        }
        
        guard let confirmEmail = confirmEmailTextfield.text, !confirmEmail.isEmpty else {
            displayError(title: "Your emails do not match", message: "Please a valid email.")
            return
        }
        
        guard let UserPassword = passwordTextField.text, !UserPassword.isEmpty else {
            displayError(title: "Missing a password", message: "Please enter a password.")
            return
        }
        
        guard let confirmPassword = confirmPasswordText.text, !confirmPassword.isEmpty else {
            displayError(title: "Confirm password empty", message: "Please enter your password.")
            return
        }
        //end
        
        
        //checks if the passwords and emails match each other
        if userEmail != confirmEmail {
            print(email)
            displayError(title: "Your emails do not match", message: "Please make sure your emails match")
        } else {
            email = userEmail
            print(email)
        }
        
        if UserPassword != confirmPassword {
            print(password)
            displayError(title: "Your passwords do not match", message: "Please make sure your passwords match")
        } else  {
            password = UserPassword
            print(password)
        }
        //end
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if let firebase = error {
                print(error)
                return
            }
            let userID = Auth.auth().currentUser!.uid

            self.sendVerificationMail()
            //creates a new user in the database numberOfQuizzesTaken
            self.ref?.child("users").child(userID).setValue(userID)
            self.ref?.child("users").child(userID).child("username").setValue(username)
            self.ref?.child("users").child(userID).child("email").setValue(userEmail)
            self.ref?.child("users").child(userID).child("verified").setValue(false)
            self.ref?.child("users").child(userID).child("isAdmin").setValue(false)
            self.ref?.child("users").child(userID).child("userID").setValue(userID)
            self.ref?.child("users").child(userID).child("numberOfQuizzesTaken").setValue(0)
            self.ref?.child("users").child(userID).child("QuizScores").child("totalPercent").setValue(0)
            self.ref?.child("users").child(userID).child("QuizScores").child("region").child("test").child("test").setValue(0)
        }
        self.displayError(title: "Verification email sent", message: "Please check your email")
    }
    
}
