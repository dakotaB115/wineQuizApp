//
//  QuizzViewController.swift
//  wineQuizApp
//
//  Created by Dakota Brown on 2/2/19.
//  Copyright © 2019 Dakota Brown. All rights reserved.
//

import UIKit
import Firebase

class QuizzViewController: UIViewController {

    @IBOutlet weak var QuizLabel: UILabel!
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var optionOne: RoundedButton2!
    @IBOutlet weak var optionTwo: RoundedButton2!
    @IBOutlet weak var optionThree: RoundedButton2!
    @IBOutlet weak var optionFour: RoundedButton2!
    
    var qNumber: Int = 1
    var correct: Int = 0
    var wrong: Int = 0
    var total: Float = 0
    var ref: DatabaseReference!
    var totalCorrect: Int = 0
    var nums = [1,2,3,4]
    var randNum: Int = 0
    
    func rand() {
        // random key from array
        let arrayKey = Int(arc4random_uniform(UInt32(nums.count)))
        
        // your random number
        randNum = nums[arrayKey]
        print(randNum)
        
        // make sure the number isnt repeated
        nums.remove(at: arrayKey)
    }
    
    func randomQuestions() {
        ref?.child("Regions").child(quizType).child(String(self.qNumber)).observeSingleEvent(of: .value, with: { (snapshot) in

            let value = snapshot.value as? NSDictionary
            let questionSnap = value?["Question"] as? String ?? ""
            let correctSnap = value?["Answer"] as? String ?? ""
            self.rand()
            let choiceOneSnap = value?[String(self.randNum)] as? String ?? ""
            self.rand()
            let choiceTwoSnap = value?[String(self.randNum)] as? String ?? ""
            self.rand()
            let choiceThreeSnap = value?[String(self.randNum)] as? String ?? ""
            self.rand()
            let choiceFourSnap = value?[String(self.randNum)] as? String ?? ""
            
            //all in global variables
            self.nums = [1,2,3,4]
            question = questionSnap
            correctAnswer = correctSnap
            choiceOne = choiceOneSnap
            choiceTwo = choiceTwoSnap
            choiceThree = choiceThreeSnap
            choiceFour = choiceFourSnap
            
            self.QuestionLabel.text = question
            self.optionOne.setTitle(choiceOne, for: [])
            self.optionTwo.setTitle(choiceTwo, for: [])
            self.optionThree.setTitle(choiceThree, for: [])
            self.optionFour.setTitle(choiceFour, for: [])
        })
    }
    
    func displayError(title: String, message: String) {
        let title = title
        let message = message
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            //self.dismiss(animated: true)
            numberOfQuizzesTaken += 1
            self.total = ((Float(self.correct) / Float(numberOfUsers))*100).rounded(.toNearestOrEven)
            print(self.total)
            self.ref?.child("users").child(userID2).child("QuizScores").child("totalPercent").setValue(self.total)
            self.ref?.child("users").child(userID2).child("numberOfQuizzesTaken").setValue(numberOfQuizzesTaken)
            self.ref?.child("userScores").child(userID2).child("number").setValue(self.total)
            self.ref?.child("userScores").child(userID2).child("score").setValue("\(self.total)%")
            self.ref?.child("userScores").child(userID2).child("username").setValue(username)
            self.ref?.child("users").child(userID2).child("QuizScores").child("region").child(quizType).child("score").setValue(self.total)
            self.ref?.child("users").child(userID2).child("QuizScores").child("region").child(quizType).child("hasTaken").setValue(true)
            self.performSegue(withIdentifier: "unwindToQuizzes", sender: self)
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        print(numberOfUsers)
        randomQuestions()
    }

    @IBAction func optionOneButton(_ sender: Any) {
        
        guard choiceOne == correctAnswer else {
            qNumber += 1
            wrong += 1
            wrongLabel.text = String(wrong)
            questionNumberLabel.text = String(qNumber)
            
            print(self.totalCorrect)
            randomQuestions()
            
            guard qNumber != numberOfUsers else {
                wrong += 1
                wrongLabel.text = String(correct)
                self.displayError(title: "End of quiz", message: "Hope you enjoyed it!")
                return
            }
            
            return
        }
        
        guard choiceOne != correctAnswer else {
            qNumber += 1
            correct += 1
            correctLabel.text = String(correct)
            questionNumberLabel.text = String(qNumber)
            print(self.total)
            randomQuestions()
            
            guard qNumber != numberOfUsers else {
                correct += 1
                correctLabel.text = String(correct)
                self.displayError(title: "End of quiz", message: "Hope you enjoyed it!")
                return
            }
            
            return
        }
        
    }
    
    @IBAction func optionTwoButton(_ sender: Any) {
        
        guard choiceTwo == correctAnswer else {
            qNumber += 1
            wrong += 1
            wrongLabel.text = ("\(wrong)")
            questionNumberLabel.text = ("\(qNumber)")
            print(self.total)
            randomQuestions()
            
            guard qNumber != numberOfUsers else {
                wrong += 1
                wrongLabel.text = String(correct)
                self.displayError(title: "End of quiz", message: "Hope you enjoyed it!")
                return
            }
            
            return
        }
        
        guard choiceTwo != correctAnswer else {
            qNumber += 1
            correct += 1
            correctLabel.text = ("\(correct)")
            questionNumberLabel.text = ("\(qNumber)")
            print(self.total)
            randomQuestions()
            
            guard qNumber != numberOfUsers else {
                correct += 1
                correctLabel.text = String(correct)
                self.displayError(title: "End of quiz", message: "Hope you enjoyed it!")
                return
            }
            
            return
        }
    }
    
    @IBAction func optionThreeButton(_ sender: Any) {
        
        guard choiceThree == correctAnswer else {
            qNumber += 1
            wrong += 1
            wrongLabel.text = ("\(wrong)")
            questionNumberLabel.text = ("\(qNumber)")
            print(self.total)
            randomQuestions()
            
            guard qNumber != numberOfUsers else {
                wrong += 1
                wrongLabel.text = String(correct)
                self.displayError(title: "End of quiz", message: "Hope you enjoyed it!")
                return
            }
            
            return
        }
        
        guard choiceThree != correctAnswer else {
            qNumber += 1
            correct += 1
            correctLabel.text = ("\(correct)")
            questionNumberLabel.text = ("\(qNumber)")
            print(self.total)
            randomQuestions()
            
            guard qNumber != numberOfUsers else {
                correct += 1
                correctLabel.text = String(correct)
                self.displayError(title: "End of quiz", message: "Hope you enjoyed it!")
                return
            }
            
            return
        }
    }
    
    @IBAction func optionFourButton(_ sender: Any) {
        
        guard choiceFour == correctAnswer else {
            qNumber += 1
            wrong += 1
            wrongLabel.text = ("\(wrong)")
            questionNumberLabel.text = ("\(qNumber)")
            print(self.total)
            randomQuestions()
            
            guard qNumber != numberOfUsers else {
                wrong += 1
                wrongLabel.text = String(correct)
                self.displayError(title: "End of quiz", message: "Hope you enjoyed it!")
                return
            }
            
            return
        }
        
        guard choiceFour != correctAnswer else {
            qNumber += 1
            correct += 1
            correctLabel.text = ("\(correct)")
            questionNumberLabel.text = ("\(qNumber)")
            print(self.total)
            randomQuestions()
            
            guard qNumber != numberOfUsers else {
                correct += 1
                correctLabel.text = String(correct)
                self.displayError(title: "End of quiz", message: "Hope you enjoyed it!")
                return
            }
            
            return
        }
    }
}
