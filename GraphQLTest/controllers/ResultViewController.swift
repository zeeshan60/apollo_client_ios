//
//  ResultViewController.swift
//  GraphQLTest
//
//  Created by Zeeshan Tufail on 15/12/19.
//  Copyright © 2019 Zeeshan Tufail. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView : UITableView!

    var dataSource : [Subject]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.dataSource = Subject.findAll()?.filter { (subject: Subject) -> Bool in subject.testTaken ?? false }

        self.reloadData()
    }

    func reloadData() {
        self.tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default_cell")
        cell?.textLabel?.text = dataSource?[indexPath.row].name
        let subject: Subject? = self.dataSource?[indexPath.row]
        let correctQuestions: Array<Question>? = subject?.questions?.filter { (question: Question) -> Bool in
            question.isAnsweredCorrect()
        }
        cell?.detailTextLabel?.text = "Percentage: \((correctQuestions?.count ?? 0 * 100) / (subject?.questions?.count ?? 1))%"
        return cell!
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
