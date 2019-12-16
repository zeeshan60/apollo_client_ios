//
//  SubjectContentView.swift
//  GraphQLTest
//
//  Created by Noman Tufail on 4/12/19.
//  Copyright © 2019 Noman Tufail. All rights reserved.
//

import UIKit

class SubjectContentView: UIView {

    weak var delegate: FirstViewController?;
    @IBOutlet weak var lblSubjectName: UILabel!;
    @IBOutlet weak var btnTakeTest: UIButton!;
    @IBOutlet weak var btnSchedule: UIButton!;

    var subject: Subject?

    func reloadContent(subject: Subject) {
        self.subject = subject
        lblSubjectName.text = subject.name

        self.layer.cornerRadius = 8
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.backgroundColor = UIColor(displayP3Red: 0.9, green: 0.9, blue: 0.85, alpha: 1)
        self.btnTakeTest.setTitle("Take Test", for: .normal)
        self.btnTakeTest.isUserInteractionEnabled = true
        self.btnTakeTest.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 0.8, alpha: 1)
        self.btnTakeTest.layer.cornerRadius = 3
        self.btnTakeTest.layer.shadowOffset = CGSize(width: 3, height: 3)
    }

    @IBAction func takeTextPressed(_ sender: Any) {
        guard let sub = subject else {
            return
        }
            delegate?.subjectTakeTestDidSelected(subject: sub)
    }

    @IBAction func schedulePressed(_ sender: Any) {
        guard let sub = subject else {
            return
        }
        delegate?.subjectScheduleDidSelected(subject: sub)
    }
}
