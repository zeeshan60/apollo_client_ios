//
//  FirstViewController.swift
//  GraphQLTest
//
//  Created by Zeeshan Tufail on 4/12/19.
//  Copyright © 2019 Zeeshan Tufail. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.subjects?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let view = collectionView.dequeueReusableCell(withReuseIdentifier: "subject_cell", for: indexPath)
        guard let subject = self.subjects?[indexPath.row] else {
            return view
        }
        if view.contentView.isKind(of: SubjectContentView.self) {
            let subjectContentView: SubjectContentView = view.contentView as! SubjectContentView
            subjectContentView.delegate = self
            subjectContentView.reloadContent(subject: subject)
        }
//        let textView = view.viewWithTag(1) as! UILabel?
//        textView?.text = self.subjects[indexPath.row]?.name
        return view
    }


    @IBOutlet weak var collectionView: UICollectionView!
    var subjects: [Subject]? = []
    var selectedSubject: Subject?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()


        //todo zeeshan enable logging
//        self.performSegue(withIdentifier: "login_segue", sender: self)

        collectionView.delegate = self
        collectionView.dataSource = self
        self.title = "Subjects"
        self.navigationItem.title = "Subjects"
    }

    private func reloadData() { // Do any additional setup after loading the view.
            Network.shared.apollo.fetch(query: GetSubjectQuery()) { result in
                switch result {
                case .success(let graphQLResult):
                    print("Success! Result: \(graphQLResult)")
                    guard let subs = graphQLResult.data?.subjects else {
                        return
                    }

                    let subjects: [Subject] = subs.map { (subject: GetSubjectQuery.Data.Subject?) -> Subject in
                        let sub = Subject(subject: subject!)
                        let existing = Subject.find(id: sub.id!)
                        if (existing != nil) {
                            sub.totalAttempts = existing?.totalAttempts ?? 0
                            sub.successAttempts = existing?.successAttempts ?? 0
                            sub.scheduled = existing?.scheduled ?? false
                        }
                        return sub
                    }
                    Subject.saveAll(subjects: subjects)
                    DispatchQueue.main.async {

                        self.loadData(subjects: (subjects))
                    }
                case .failure(let error):
                    print("Failure! Error: \(error)")
                }
            }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.reloadData()
    }

    func loadData(subjects: [Subject]) {
        self.subjects = subjects
        collectionView.reloadData()
    }

    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: screenWidth / 2.15, height: 190)
    }

    func subjectTakeTestDidSelected(subject: Subject!) {

        self.selectedSubject = subject
        self.performSegue(withIdentifier: "take_test", sender: self)
    }

    func subjectShowResultDidSelected(subject: Subject!) {

        self.selectedSubject = subject
        self.performSegue(withIdentifier: "show_result", sender: self)
    }

    func subjectScheduleDidSelected(subject: Subject) {

        subject.scheduled = true
        subject.save()
        self.reloadData()

        let alert = UIAlertController(title: "Scheduled", message: "You can continue your test from schedules anytime.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "take_test" {
            let controller = segue.destination as! QuestionViewController

            controller.subject = self.selectedSubject
        }
    }
}
