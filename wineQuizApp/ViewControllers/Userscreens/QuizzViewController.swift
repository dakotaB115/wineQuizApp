//
//  QuizzViewController.swift
//  wineQuizApp
//
//  Created by Dakota Brown on 1/15/19.
//  Copyright © 2019 Dakota Brown. All rights reserved.
//

import UIKit
import Firebase

class QuizzViewController: UIViewController {

    @IBOutlet weak var quizLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var questionsWrongLabel: UILabel!
    @IBOutlet weak var questionsCorrectLabel: UILabel!
    @IBOutlet weak var optionOne: RoundedButton2!
    @IBOutlet weak var optionTwo: RoundedButton2!
    @IBOutlet weak var optionThree: RoundedButton2!
    @IBOutlet weak var optionFour: RoundedButton2!
    
    var qNumber: Int = 0
    var rand: Int = 0
    var numberOfQuestions = 12
    var correct: Int = 0
    var wrong: Int = 0
    var total: Float = 0
    var ref: DatabaseReference!
    var totalCorrect: Int = 0

    func quizData() {
        ref?.child("Regions").child(quizType).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let quizSnap = value?["quizz"] as? String ?? ""
            
            self.quizLabel.text = quizSnap
        })
        
        ref?.child("users").child(userID2).child("QuizScores").child("reigion").child(quizType).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let takenSnap = value?["hasTaken"] as? Bool ?? false
            
            hasTaken = takenSnap
            print(hasTaken)
        })
        ref?.child("users").child(userID2).child("QuizScores").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let totalSnap = value?["totalPercent"] as? Int ?? 0
            
            self.totalCorrect = totalSnap
            print(self.totalCorrect)
        })
        ref?.child("users").child(userID2).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let numberOfQuizzesTakenSnap = value?["numberOfQuizzesTaken"] as? Int ?? 0
            
            numberOfQuizzesTaken = numberOfQuizzesTakenSnap
            print(numberOfQuizzesTaken)
        })
    }
    
    func randomQuestions() {
        ref?.child("Regions").child(quizType).child(String(self.qNumber)).observeSingleEvent(of: .value, with: { (snapshot) in
            
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
        })
        
        self.questionLabel.text = question
        self.optionOne.setTitle(choiceOne, for: [])
        self.optionTwo.setTitle(choiceTwo, for: [])
        self.optionThree.setTitle(choiceThree, for: [])
        self.optionFour.setTitle(choiceFour, for: [])
    }
    
    func displayError(title: String, message: String) {
        let title = title
        let message = message
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            //self.dismiss(animated: true)
            numberOfQuizzesTaken += 1
            self.total = ((Float(self.correct) / 11)*100).rounded(.toNearestOrEven)
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
        qNumber = 0
        quizData()
        ref.child("Regions").child(quizType).observe(.value, with: { (snapshot: DataSnapshot!) in
            print(snapshot.childrenCount)
            let snapshot = snapshot.childrenCount
            print(snapshot)
        })
        ref?.child("users").child(userID2).child("QuizScores").child("region").child(quizType).child("hasTaken").setValue(false)
        ref?.child("users").child(userID2).child("QuizScores").child("region").child(quizType).child("quiz").setValue(quizType)
        ref?.child("users").child(userID2).child("QuizScores").child("region").child(quizType).child("score").setValue("N/A")
        randomQuestions()
        questionLabel.text = "Press a button to start playing"
    }

    @IBAction func optionOneButton(_ sender: Any) {
        
        guard qNumber != 0 else {
            randomQuestions()
            qNumber += 1
            return
        }
        
        guard qNumber != numberOfQuestions else {
            self.displayError(title: "End of quiz", message: "Hope you enjoyed it!")
            return
        }
        
        guard choiceOne == correctAnswer else {
            qNumber += 1
            wrong += 1
            questionsWrongLabel.text = ("Questions wrong: \(wrong)")
            questionNumber.text = ("Question number: \(qNumber)")
            
            print(self.totalCorrect)
            randomQuestions()
            return
        }
        
        guard choiceOne != correctAnswer else {
            qNumber += 1
            correct += 1
            questionsCorrectLabel.text = ("Questions correct: \(correct)")
            questionNumber.text = ("Question number: \(qNumber)")
            print(self.total)
            randomQuestions()
            return
        }

    }
    
    @IBAction func optionTwoButton(_ sender: Any) {
        
        guard qNumber != 0 else {
            randomQuestions()
            qNumber += 1
            return
        }
        
        guard qNumber != numberOfQuestions else {
            self.displayError(title: "End of quiz", message: "Hope you enjoyed it!")
            return
        }
        
        guard choiceTwo == correctAnswer else {
            qNumber += 1
            wrong += 1
            questionsWrongLabel.text = ("Questions wrong: \(wrong)")
            questionNumber.text = ("Question number: \(qNumber)")
            print(self.total)
            randomQuestions()
            return
        }
        
        guard choiceTwo != correctAnswer else {
            qNumber += 1
            correct += 1
            questionsCorrectLabel.text = ("Questions correct: \(correct)")
            questionNumber.text = ("Question number: \(qNumber)")
            print(self.total)
            randomQuestions()
            return
        }
        
    }
    
    @IBAction func optionThreeButton(_ sender: Any) {
        
        guard qNumber != 0 else {
            randomQuestions()
            qNumber += 1
            return
        }
        
        guard qNumber != numberOfQuestions else {
            self.displayError(title: "End of quiz", message: "Hope you enjoyed it!")
            return
        }
        
        guard choiceThree == correctAnswer else {
            qNumber += 1
            wrong += 1
            questionsWrongLabel.text = ("Questions wrong: \(wrong)")
            questionNumber.text = ("Question number: \(qNumber)")
            
            print(self.total)
            randomQuestions()
            return
        }
        
        guard choiceThree != correctAnswer else {
            qNumber += 1
            correct += 1
            questionsCorrectLabel.text = ("Questions correct: \(correct)")
            questionNumber.text = ("Question number: \(qNumber)")
            print(self.total)
            randomQuestions()
            return
        }
        
    }
    
    @IBAction func OptionFourButton(_ sender: Any) {
        
        guard qNumber != 0 else {
            randomQuestions()
            qNumber += 1
            return
        }
        
        guard qNumber != numberOfQuestions else {
            self.displayError(title: "End of quiz", message: "Hope you enjoyed it!")
            return
        }
        
        guard choiceFour == correctAnswer else {
            qNumber += 1
            wrong += 1
            questionsWrongLabel.text = ("Questions wrong: \(wrong)")
            questionNumber.text = ("Question number: \(qNumber)")
            print(self.total)
            randomQuestions()
            return
        }
        guard choiceFour != correctAnswer else {
            qNumber += 1
            correct += 1
            questionsCorrectLabel.text = ("Questions correct: \(correct)")
            questionNumber.text = ("Question number: \(qNumber)")
            print(self.total)
            randomQuestions()
            return
        }
        
    }
    
}
