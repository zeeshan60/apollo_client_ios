//
//  SubjectContentView.swift
//  GraphQLTest
//
//  Created by Zeeshan Tufail on 4/12/19.
//  Copyright © 2019 Zeeshan Tufail. All rights reserved.
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

        if subject.testTaken ?? false {
            self.btnTakeTest.setTitle("Test submitted", for: .normal)
            self.btnTakeTest.isUserInteractionEnabled = false
            self.btnTakeTest.backgroundColor = UIColor.clear
            self.btnSchedule.isHidden = true
        } else {
            self.btnTakeTest.setTitle("Take Test", for: .normal)
            self.btnTakeTest.isUserInteractionEnabled = true
            self.btnTakeTest.backgroundColor = UIColor.orange

            self.btnSchedule.isHidden = subject.scheduled
        }
    }

    @IBAction func takeTextPressed(_ sender: Any) {
        guard let sub = subject else {
            return
        }
        if sub.testTaken ?? false {

        } else {

            delegate?.subjectTakeTestDidSelected(subject: sub)
        }
    }
    @IBAction func schedulePressed(_ sender: Any) {
        guard let sub = subject else {
            return
        }
        delegate?.subjectScheduleDidSelected(subject: sub)
    }
}
