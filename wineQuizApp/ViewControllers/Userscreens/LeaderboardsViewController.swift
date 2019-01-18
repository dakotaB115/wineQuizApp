//
//  LeaderboardsViewController.swift
//  wineQuizApp
//
//  Created by Dakota Brown on 1/15/19.
//  Copyright © 2019 Dakota Brown. All rights reserved.
//

import UIKit
import Firebase

class LeaderboardsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var leaderboardTableView: UITableView!
    
    var ref: DatabaseReference!

    var users = [Leaderboard]() {
        didSet {
            leaderboardTableView.reloadData()
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Hide separators for empty cells
        leaderboardTableView.tableFooterView = UIView()
        self.leaderboardTableView.rowHeight = 60
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ref.child("userScores").observe(.value) { snapshot in
            var users = [Leaderboard]()
            for userSnapshot in snapshot.children {
                let user = Leaderboard(snapshot: userSnapshot as! DataSnapshot)
                users.append(user)
            }
            self.users = users
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaderboardCell", for: indexPath) as!
            LeaderboardTableViewCell
        cell.individualUser = users[indexPath.row]
        return cell
    }
}
