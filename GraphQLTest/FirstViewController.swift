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
        return self.subjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let view = collectionView.dequeueReusableCell(withReuseIdentifier: "subject_cell", for: indexPath)
        let subjectName = self.subjects[indexPath.row]?.name
        let subjectId = self.subjects[indexPath.row]?.id
        if view.contentView.isKind(of: SubjectContentView.self) {
            let subjectContentView : SubjectContentView = view.contentView as! SubjectContentView
            subjectContentView.delegate = self
            subjectContentView.reloadContent(viewModel: SubjectViewModel(id: subjectId, name: subjectName))
        }
//        let textView = view.viewWithTag(1) as! UILabel?
//        textView?.text = self.subjects[indexPath.row]?.name
        return view
    }
    

    @IBOutlet weak var collectionView: UICollectionView!
    var subjects: [GetSubjectQuery.Data.Subject?] = []
    var selectedSubject : GetSubjectQuery.Data.Subject?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        title = "Subjects"
        // Do any additional setup after loading the view.
        Network.shared.apollo.fetch(query: GetSubjectQuery()) { result in
          switch result {
          case .success(let graphQLResult):
            print("Success! Result: \(graphQLResult)")
            self.loadData(subjects: (graphQLResult.data?.subjects)!)
          case .failure(let error):
            print("Failure! Error: \(error)")
          }
        }
    }

    func loadData(subjects: [GetSubjectQuery.Data.Subject?]) {
        self.subjects = subjects
        collectionView.reloadData()
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 190, height: 190)
//    }
    
    func subjectTakeTestDidSelected(subject: SubjectViewModel!) {
        
        self.subjects.forEach({ (isub) in
            if isub?.id == subject?.id {
                self.selectedSubject = isub
            }
        });
        self.performSegue(withIdentifier: "take_test", sender: self)
    }
    
    func subjectScheduleDidSelected(subject: SubjectViewModel) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "take_test" {
            let controller = segue.destination as! QuestionViewController
            controller.dataSource = self.selectedSubject?.questions
        }
    }
}

