//
//  SecondViewController.swift
//  GraphQLTest
//
//  Created by Zeeshan Tufail on 4/12/19.
//  Copyright © 2019 Zeeshan Tufail. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var dataSource: [Subject]?

    private var selectedSubject: Subject?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self

        self.title = "Schedules"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadData()
    }

    private func reloadData() {
        dataSource = Subject.findAll()?.filter { (subject: Subject) -> Bool in
            subject.scheduled
        }
        self.tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "default_cell", for: indexPath)
        cell.textLabel?.text = dataSource?[indexPath.row].name
        cell.detailTextLabel?.text = "Scheduled"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.subjectSelected(subject: self.dataSource?[indexPath.row])
    }

    func subjectSelected(subject: Subject!) {

        self.selectedSubject = subject
        self.performSegue(withIdentifier: "take_test", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "take_test" {
            let controller = segue.destination as! QuestionViewController

            controller.subject = Subject.find(id: self.selectedSubject!.id!)
        }
    }
}

