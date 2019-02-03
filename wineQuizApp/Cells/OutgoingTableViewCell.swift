//
//  OutgoingTableViewCell.swift
//  wineQuizApp
//
//  Created by Dakota Brown on 2/2/19.
//  Copyright © 2019 Dakota Brown. All rights reserved.
//

import UIKit

class OutgoingTableViewCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
