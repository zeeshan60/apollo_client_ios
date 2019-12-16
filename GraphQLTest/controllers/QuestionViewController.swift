//
//  QuestionViewController.swift
//  GraphQLTest
//
//  Created by Noman Tufail on 4/12/19.
//  Copyright © 2019 Noman Tufail. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    let containerStartIndex: Int = 100

    var subject: Subject?
    var selectedQuestionIndex: Int = 0
    var timer: Timer?
    var totalTime: Int?
    var alertShown: Bool = false

    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var choice1Container: UIView!
    @IBOutlet weak var lbl1Choice: UILabel!
    @IBOutlet weak var choice2Container: UIView!
    @IBOutlet weak var lbl2Choice: UILabel!
    @IBOutlet weak var choice3Container: UIView!
    @IBOutlet weak var lbl3Choice: UILabel!
    @IBOutlet weak var choice4Container: UIView!
    @IBOutlet weak var lbl4Choice: UILabel!
    @IBOutlet weak var lblTimer: UILabel!

    @IBOutlet weak var questionContainer: UIView!


    override func viewDidLoad() {
        super.viewDidLoad()

//        self.subject!.timeRequired = 10
        self.totalTime = (self.subject?.timeRequired ?? 45) * 60

        self.updateTimer(totalTime: self.totalTime!)

        self.startOtpTimer()
        // Do any additional setup after loading the view.

        loadQuestion()
    }

    private func loadQuestion() {
        unselectAllChoices()
        var index: Int = selectedQuestionIndex
        
        if selectedQuestionIndex >= self.subject?.questions?.count ?? 0 {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        index += 1
        title = String(format: "Question: %d", index)
        hideChoices()
        self.lblQuestion.text = self.subject!.questions?[selectedQuestionIndex].title
        
        guard let choices: [Choice] = self.subject?.questions?[selectedQuestionIndex].choices else {
            return
        }

        for (index, choice) in choices.enumerated() {
            let chView = containerForChoice(index: index)
            chView?.isHidden = false
            let lbl: UILabel? = chView?.viewWithTag(9) as! UILabel?
            lbl?.text = choice.title
        }
    }

    private func hideChoices() {
        for index in 0...9 {
            containerForChoice(index: index)?.isHidden = true
        }
    }

    private func containerForChoice(index: Int) -> UIView? {

        self.view.viewWithTag(self.containerStartIndex + index)
    }

    @IBAction func choice1Click(sender: UIButton) {
        unselectAllChoices()
        self.choice1Container.backgroundColor = UIColor.lightGray
        self.subject?.questions?[selectedQuestionIndex].choices?[0].selected = true
    }

    @IBAction func choice2Click(sender: UIButton) {
        unselectAllChoices()
        self.choice2Container.backgroundColor = UIColor.lightGray
        self.subject?.questions?[selectedQuestionIndex].choices?[1].selected = true

    }

    @IBAction func choice3Click(sender: UIButton) {
        unselectAllChoices()
        self.choice3Container.backgroundColor = UIColor.lightGray
        self.subject?.questions?[selectedQuestionIndex].choices?[2].selected = true

    }

    @IBAction func choice4Click(sender: UIButton) {
        unselectAllChoices()
        self.choice4Container.backgroundColor = UIColor.lightGray
        self.subject?.questions?[selectedQuestionIndex].choices?[3].selected = true

    }

    private func unselectAllChoices() {
        self.choice1Container.backgroundColor = UIColor.clear
        self.choice2Container.backgroundColor = UIColor.clear
        self.choice3Container.backgroundColor = UIColor.clear
        self.choice4Container.backgroundColor = UIColor.clear
    }

    @IBAction func nextClick(sender: UIButton) {

        UIView.animate(withDuration: 0.2,
                animations: { [weak self] () -> Void in self?.questionContainer.alpha = 0.2 },
                completion: { [weak self] b in

                    guard let self = self else {
                        return
                    }

                    self.selectedQuestionIndex += 1
                    if self.subject?.questions?.count == self.selectedQuestionIndex {
                        self.finishTest()
                        return;
                    }
                    self.loadQuestion()
                    UIView.animate(withDuration: 0.2,
                            animations: { () -> Void in self.questionContainer.alpha = 1 })
                })
    }

    private func startOtpTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self]timer in
            guard let self = self else {
                return
            }
            guard let totalTime = self.totalTime else {
                return
            }

            if !self.alertShown && totalTime <= self.subject!.timeRequired! / 2 {

                let alert = UIAlertController(title: "Alert!", message: "Half time passed", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.alertShown = true
            }

            self.updateTimer(totalTime: totalTime)

            if totalTime != 0 {
                self.totalTime! -= 1  // decrease counter timer
            } else {
                if let timer = self.timer {
                    timer.invalidate()
                    self.timer = nil
                }


                let alert = UIAlertController(title: "Timeout!", message: "Out of time. Your current answers have been submitted.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .destructive) { action in  self.finishTest()})
                self.present(alert, animated: true, completion: nil)
            }}
    }

    private func finishTest() {

        subject?.testTaken = true
        subject?.save()
        self.performSegue(withIdentifier: "result_segue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "result_segue" {
            let controller = segue.destination as! ResultViewController

            controller.dataSource = self.subject
        }
    }

    private func updateTimer(totalTime: Int) {
        self.lblTimer.text = self.timeFormatted(totalTime) // will show timer
    }

    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    deinit  {
        self.timer?.invalidate()
        self.timer = nil
    }
}
