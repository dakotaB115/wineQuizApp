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

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var dividerLabel1: UILabel!
    @IBOutlet weak var dividerLabel2: UILabel!
    
    let newSwiftColor = UIColor(red: 36, green: 45, blue: 107)
    var ref: DatabaseReference!
    var newUser: Int = 0
    var passwordEmail: String = ""
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    /*private var authUser : User? {
        return Auth.auth().currentUser
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets the textfields to nothing
        EmailTextField.text = ""
        EmailTextField.underlined()
        PasswordTextField.text = ""
        PasswordTextField.underlined()
        
        logoImageView.layer.borderWidth = 1
        logoImageView.layer.masksToBounds = false
        logoImageView.layer.borderColor = UIColor.white.cgColor
        logoImageView.layer.cornerRadius = logoImageView.frame.height/8
        logoImageView.clipsToBounds = true
        
        navigationController?.navigationBar.barTintColor = newSwiftColor
        self.setNeedsStatusBarAppearanceUpdate()
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "toUserScreens", sender: self)
        } else {
            
        }
    }
    
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
    
    func alertEntry(title: String, message: String, input: String) {
        let title = title
        let message = message
        let input =  input
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = input
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]// Force unwrapping because we know it exists.
            self.passwordEmail = textField!.text!
            print("Text field: \(self.passwordEmail)")
            Auth.auth().sendPasswordReset(withEmail: self.passwordEmail) { error in
            }
            self.displayError(title: "Password change", message: "Email sent")
        }))
        
        self.present(alert, animated: true)
    }
    
    @IBAction func LoginButtonPressed(_ sender: Any) {
        let auth = Auth.auth()
        
        guard let email = EmailTextField.text, let password = PasswordTextField.text else {
            print("No email or password")
            return
        }
        
        auth.signIn(withEmail: email, password: password) {
            (user, error) in
            if let user = auth.currentUser {
                if !user.isEmailVerified{
                    let alertVC = UIAlertController(title: "Error", message: "Sorry. Your email address has not yet been verified. Do you want us to send another verification email to \(email).", preferredStyle: .alert)
                    let alertActionOkay = UIAlertAction(title: "Okay", style: .default) {
                        (_) in
                        user.sendEmailVerification(completion: nil)
                    }
                    let alertActionCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                    
                    alertVC.addAction(alertActionOkay)
                    alertVC.addAction(alertActionCancel)
                    self.present(alertVC, animated: true, completion: nil)
                } else {
                    self.performSegue(withIdentifier: "toUserScreens", sender: self)
                }
            }
        }
    }
    
    @IBAction func ForgotPasswordButtonPressed(_ sender: Any) {
        self.alertEntry(title: "Change password", message: "Please enter your email", input: "Email:")
    }
    
    @IBAction func RegisterButtonPressed(_ sender: Any) {
    }
    
    @IBAction func unwindToLogin(segue:UIStoryboardSegue) { }
}
