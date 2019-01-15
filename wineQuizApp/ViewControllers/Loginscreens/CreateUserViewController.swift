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
    
    @IBAction func registerUserButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToLogin", sender: self)
    }
    
}
