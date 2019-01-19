//
//  QuizzTableViewCell.swift
//  wineQuizApp
//
//  Created by Dakota Brown on 1/18/19.
//  Copyright © 2019 Dakota Brown. All rights reserved.
//

import UIKit

class QuizzTableViewCell: UITableViewCell {

    @IBOutlet weak var quizLabel: UILabel!
    
    var quiz: Quizz? {
        didSet {
            if let quiz = quiz {
                quizLabel.text = quiz.quizz
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
         super.prepareForReuse()
        quizLabel.text = "Quizz"
    }
    
    @IBAction func takeThisQuizButton(_ sender: Any) {
        quizType = quizLabel.text as! String
        print(quizType)
    }
}
