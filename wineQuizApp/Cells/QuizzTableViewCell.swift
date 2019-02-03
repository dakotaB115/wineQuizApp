//
//  QuizzTableViewCell.swift
//  wineQuizApp
//
//  Created by Dakota Brown on 1/18/19.
//  Copyright © 2019 Dakota Brown. All rights reserved.
//

import UIKit
import Firebase

class QuizzTableViewCell: UITableViewCell {

    @IBOutlet weak var quizLabel: UILabel!
    var ref: DatabaseReference!

    override func awakeFromNib() {
        super.awakeFromNib()
        ref = Database.database().reference()
    }
    
    var quiz: Quizz? {
        didSet {
            if let quiz = quiz {
                quizLabel.text = quiz.quizz
            }
        }
    }

    override func prepareForReuse() {
         super.prepareForReuse()
        quizLabel.text = "Quizz"
    }
    
    @IBAction func takeThisQuizButton(_ sender: Any) {
        quizType = quizLabel.text as! String
        print(quizType)
        print(numberOfUsers)
        
        /*ref.child("Regions").child(quizType).child("1").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let questionSnap = value?["Question"] as? String ?? ""
            let correctSnap = value?["Answer"] as? String ?? ""
            let choiceOneSnap = value?["1"] as? String ?? ""
            let choiceTwoSnap = value?["2"] as? String ?? ""
            let choiceThreeSnap = value?["3"] as? String ?? ""
            let choiceFourSnap = value?["4"] as? String ?? ""
            
            //all in global variables
            question = questionSnap
            correctAnswer = correctSnap
            choiceOne = choiceOneSnap
            choiceTwo = choiceTwoSnap
            choiceThree = choiceThreeSnap
            choiceFour = choiceFourSnap
        })*/
    }
}
