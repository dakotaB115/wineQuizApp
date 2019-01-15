//
//  LoginViewController.swift
//  wineQuizApp
//
//  Created by Dakota Brown on 1/14/19.
//  Copyright © 2019 Dakota Brown. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var dividerLabel1: UILabel!
    @IBOutlet weak var dividerLabel2: UILabel!
    
    let newSwiftColor = UIColor(red: 36, green: 45, blue: 107)
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets the textfields to nothing
        EmailTextField.text = ""
        EmailTextField.underlined()
        PasswordTextField.text = ""
        PasswordTextField.underlined()
        navigationController?.navigationBar.barTintColor = newSwiftColor
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    @IBAction func LoginButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "toUserScreens", sender: self)
    }
    
    @IBAction func ForgotPasswordButtonPressed(_ sender: Any) {
    }
    
    @IBAction func RegisterButtonPressed(_ sender: Any) {
    }
    
    @IBAction func unwindToLogin(segue:UIStoryboardSegue) { }
}
