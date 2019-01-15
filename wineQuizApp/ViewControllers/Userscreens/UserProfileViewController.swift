//
//  UserProfileViewController.swift
//  wineQuizApp
//
//  Created by Dakota Brown on 1/15/19.
//  Copyright © 2019 Dakota Brown. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "logout", sender: self)
    }
    
}
