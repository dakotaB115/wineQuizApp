//
//  LeaderboardTableViewCell.swift
//  wineQuizApp
//
//  Created by Dakota Brown on 1/17/19.
//  Copyright © 2019 Dakota Brown. All rights reserved.
//

import UIKit
import Firebase

class LeaderboardTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var percentCorrectLabel: UILabel!
    
    var individualUser: Leaderboard? {
        didSet {
            if let individualUser = individualUser {
                usernameLabel.text = individualUser.username
                percentCorrectLabel.text = ("Percent of questions got correct: \(individualUser.score)")
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        usernameLabel.text = "Username"
        percentCorrectLabel.text = "Percent of questions got correct:"
    }
}
