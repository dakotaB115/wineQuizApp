//
//  QuizzesViewController.swift
//  wineQuizApp
//
//  Created by Dakota Brown on 1/15/19.
//  Copyright © 2019 Dakota Brown. All rights reserved.
//quizViewCell

import UIKit
import Firebase

class QuizzesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var quizTableView: UITableView!
   
    var ref: DatabaseReference!
    
    var quizzes = [Quizz]() {
        didSet {
            quizTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ref.child("Regions").observe(.value) { snapshot in
            var quizzes = [Quizz]()
            for quizSnapshot in snapshot.children {
                let quiz = Quizz(snapshot: quizSnapshot as! DataSnapshot)
                quizzes.append(quiz)
            }
            self.quizzes = quizzes
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizViewCell", for: indexPath) as! QuizzTableViewCell
        cell.quiz = quizzes[indexPath.row]
        return cell
    }
    
    @IBAction func unwindToQuizzes(segue:UIStoryboardSegue) { }
}
