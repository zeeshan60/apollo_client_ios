//
//  QuestionViewController.swift
//  GraphQLTest
//
//  Created by Zeeshan Tufail on 4/12/19.
//  Copyright © 2019 Zeeshan Tufail. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    var currentQuestionIndex: Int = 0
    var dataSource: [GetSubjectQuery.Data.Subject.Question?]?
    var selectedChoice: GetSubjectQuery.Data.Subject.Question.Choice?
    override func viewDidLoad() {
        super.viewDidLoad()

        title = String(format: "Question: %d", self.currentQuestionIndex)
        // Do any additional setup after loading the view.
        guard let data = dataSource else {
            return
        }
        
        
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
