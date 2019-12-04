//
//  SubjectContentView.swift
//  GraphQLTest
//
//  Created by Zeeshan Tufail on 4/12/19.
//  Copyright © 2019 Zeeshan Tufail. All rights reserved.
//

import UIKit

class SubjectViewModel {
    var id : String!
    var name : String!
    
    init(id: String!, name: String!) {
        self.id = id
        self.name = name
    }
}

class SubjectContentView: UIView {

    weak var delegate: FirstViewController?;
    @IBOutlet weak var lblSubjectName: UILabel!;
    var viewModel : SubjectViewModel?
    
    func reloadContent(viewModel: SubjectViewModel!) {
        self.viewModel = viewModel
        lblSubjectName.text = viewModel.name
    }

    @IBAction func takeTextPressed(_ sender: Any) {
        guard let model = viewModel else {
            return
        }
        delegate?.subjectTakeTestDidSelected(subject: model)
    }
    @IBAction func schedulePressed(_ sender: Any) {
        guard let model = viewModel else {
            return
        }
        delegate?.subjectScheduleDidSelected(subject: model)
    }
}
