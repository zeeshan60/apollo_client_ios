//
//  ResultViewController.swift
//  GraphQLTest
//
//  Created by Noman Tufail on 15/12/19.
//  Copyright © 2019 Noman Tufail. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lblTotalAttempts: UILabel!
    @IBOutlet weak var lblSuccessfulAttemts: UILabel!
    @IBOutlet weak var lblfailedAttempts: UILabel!
    @IBOutlet weak var lblPercentage: UILabel!
    static func testSubject() -> Subject? {
        Subject(id: "1", name: "english", timeRequired: nil,
                questions: [
                    Question(id: nil, title: "Pakistan is a great country right!?", choices: [Choice(id: nil, title: "yes i guess", selected: true, correct: false), Choice(id: nil, title: "Don't think so", selected: false, correct: true)]),
                    Question(id: nil, title: "Pakistan is a great country right!?", choices: [Choice(id: nil, title: "yes i guess", selected: true, correct: false), Choice(id: nil, title: "Don't think so", selected: false, correct: true)]),
                    Question(id: nil, title: "Pakistan is a great country right!?", choices: [Choice(id: nil, title: "yes i guess", selected: true, correct: true)]),
                    Question(id: nil, title: "Pakistan is a great country right!?", choices: [Choice(id: nil, title: "yes i guess", selected: true, correct: true)]),
                    Question(id: nil, title: "Pakistan is a great country right!?", choices: [Choice(id: nil, title: "yes i guess", selected: true, correct: true)]),
                    Question(id: nil, title: "Pakistan is a great country right!?", choices: [Choice(id: nil, title: "yes i guess", selected: true, correct: true)]),
                    Question(id: nil, title: "Pakistan is a great country right!?", choices: [Choice(id: nil, title: "yes i guess", selected: true, correct: false), Choice(id: nil, title: "Don't think so", selected: false, correct: true)]),
                    Question(id: nil, title: "Pakistan is a great country right!?", choices: [Choice(id: nil, title: "yes i guess", selected: true, correct: false), Choice(id: nil, title: "Don't think so", selected: false, correct: true)]),
                    Question(id: nil, title: "Pakistan is a great country right!?", choices: [Choice(id: nil, title: "yes i guess", selected: true, correct: false), Choice(id: nil, title: "Don't think so", selected: false, correct: true)]),
                    Question(id: nil, title: "Pakistan is a great country right!?", choices: [Choice(id: nil, title: "yes i guess", selected: true, correct: false), Choice(id: nil, title: "Don't think so", selected: false, correct: true)])
                ],
                testTaken: nil, scheduled: false, totalAttempts: 6, successAttempts: 5)
    }

    var dataSource: Subject? = ResultViewController.testSubject()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self

        let barItem = UIBarButtonItem(title: "Home", style: .done, target: self, action: #selector(onButtonPress))
        self.navigationItem.leftBarButtonItem = barItem

        self.title = "Result"
        self.navigationController?.title = "Result"
        
        self.lblTotalAttempts.text = "\(self.dataSource!.totalAttempts)"
        self.lblSuccessfulAttemts.text = "\(self.dataSource!.successAttempts)"
        self.lblfailedAttempts.text = "\(self.dataSource!.totalAttempts - self.dataSource!.successAttempts)"
        let correctCount = self.dataSource?.questions?.filter({ (question) -> Bool in
            question.isAnsweredCorrect()
            }).count
        self.lblPercentage.text = "\(correctCount! * 100 / self.dataSource!.questions!.count)"
    }

    @objc func onButtonPress() {
        self.navigationController?.popToRootViewController(animated: true)
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource?.questions?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default_cell")
        guard let question = dataSource?.questions?[indexPath.row] else {
            return cell!
        }
        cell?.textLabel?.text = question.title
        let selectedTitle: String? = question.choices?.filter { (choice: Choice) -> Bool in
            choice.selected
        }.first?.title
        let correctTitle: String? = question.choices?.filter { (choice: Choice) -> Bool in
            choice.correct
        }.first?.title
        cell?.detailTextLabel?.text = question.isAnsweredCorrect() ? selectedTitle : "Selected:\(selectedTitle ?? "Not available")\nCorrect:\(correctTitle ?? "Not available")"
        cell?.imageView?.image = question.isAnsweredCorrect() ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "clear.fill")

        cell?.backgroundColor = question.isAnsweredCorrect() ? UIColor(displayP3Red: 0.7, green: 1, blue: 0.7, alpha: 1) : UIColor(displayP3Red: 1, green: 0.5, blue: 0.5, alpha: 1)
        return cell!
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Detail result of current attempt"
    }
}
