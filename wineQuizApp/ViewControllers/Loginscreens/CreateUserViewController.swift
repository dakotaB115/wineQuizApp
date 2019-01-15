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
    
    @IBAction func registerUserButtonPressed(_ sender: Any) {
        
        //checks to see if the textfield is empty for not and displays an error if that field isn't filled out
        guard let username = usernameTextField.text, !username.isEmpty else {
            displayError(title: "Missing an username", message: "Please enter an username.")
            return
        }
        
        guard let email = emailTextfield.text, !email.isEmpty else {
            displayError(title: "Missing an email", message: "Please enter an email.")
            return
        }
        
        guard let confirmEmail = confirmEmailTextfield.text, !confirmEmail.isEmpty else {
            displayError(title: "Your emails do not match", message: "Please a valid email.")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            displayError(title: "Missing a password", message: "Please enter a password.")
            return
        }
        
        guard let confirmPassword = confirmPasswordText.text, !confirmPassword.isEmpty else {
            displayError(title: "Your passwords do not match", message: "Please re-enter your password.")
            return
        }




        
        self.performSegue(withIdentifier: "unwindToLogin", sender: self)
    }
    
}
