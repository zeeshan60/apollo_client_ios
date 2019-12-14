//
//  Subject.swift
//  GraphQLTest
//
//  Created by Zeeshan Tufail on 14/12/19.
//  Copyright © 2019 Zeeshan Tufail. All rights reserved.
//

import UIKit

class Subject: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool = true


    var id: String?
    var name: String?
    var timeRequired: Int?
    var questions: [Question]?
    var testTaken: Bool?
    var scheduled: Bool = false

    init(subject: GetSubjectQuery.Data.Subject) {
        self.id = subject.id
        self.name = subject.name
        self.questions = subject.questions?.map { question -> Question in
            Question(question: question!)
        }
        self.timeRequired = subject.timeRequired
        self.testTaken = false
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: "id")
        coder.encode(self.name, forKey: "title")
        coder.encode(self.questions, forKey: "questions")
        coder.encode(self.timeRequired, forKey: "timeRequired")
        coder.encode(self.testTaken, forKey: "testTaken")
        coder.encode(self.scheduled, forKey: "scheduled")
    }

    required init?(coder: NSCoder) {
        super.init()
        self.id = (coder.decodeObject(forKey: "id") as? String)
        self.name = (coder.decodeObject(forKey: "title") as? String)
        self.questions = (coder.decodeObject(forKey: "questions") as? [Question])
        self.timeRequired = (coder.decodeObject(forKey: "timeRequired") as? Int)
        self.testTaken = (coder.decodeObject(forKey: "testTaken") as? Bool)
        self.scheduled = coder.decodeBool(forKey: "scheduled")
    }

    func toData() -> Data? {
        do {
            return try NSKeyedArchiver.archivedData(withRootObject: [self], requiringSecureCoding: false)
        } catch {
            return nil;
        }
    }

    public static func subjectUsingData(data: Data) -> Subject? {
        do {
            let object = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [Subject.classForKeyedUnarchiver(), NSArray.classForKeyedUnarchiver(), Question.classForKeyedUnarchiver(), Choice.classForKeyedUnarchiver()], from: data)
            return (object as? Array)?[0]
        } catch {
            print(error)
            return nil;
        }
    }

    func save() {

        let subjectOpt = Subject.findAll()
        var subjects: [Subject] = subjectOpt ?? []
        var foundIndex = -1
        subjects.enumerated().forEach { (index: Int, subject: Subject) in
            if subject.id == self.id! {
                foundIndex = index
            }
        }
        if foundIndex != -1 {
            subjects.remove(at: foundIndex)
            subjects.insert(self, at: foundIndex)
        } else {

            subjects.append(self)
        }


        Subject.saveAll(subjects: subjects)
    }

    static func find(id: String) -> Subject? {

        findAll()?.filter { (subject: Subject) -> Bool in
            subject.id == id
        }.first
    }

    static func saveAll(subjects: [Subject]?) {
        guard let subs = subjects else {

            UserDefaults.standard.removeObject(forKey: "subjects")
            return
        }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: subs, requiringSecureCoding: false)
            UserDefaults.standard.set(data, forKey: "subjects")
        } catch {
        }

    }

    static func findAll() -> [Subject]? {

        let dataOpt: Data? = UserDefaults.standard.value(forKey: "subjects") as? Data ?? nil
        guard let data = dataOpt else {
            return nil
        }
        do {
            let object = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [Subject.classForKeyedUnarchiver(), NSDictionary.classForKeyedUnarchiver(), NSArray.classForKeyedUnarchiver(), Question.classForKeyedUnarchiver(), Choice.classForKeyedUnarchiver()], from: data)
            return object as? Array
        } catch {
            print(error)
            return nil;
        }
    }

}

class Question: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool = true


    var id: String?
    var title: String?
    var choices: [Choice]?

    init(question: GetSubjectQuery.Data.Subject.Question) {
        self.id = question.id
        self.title = question.title
        self.choices = question.choices?.map { choice -> Choice in
            Choice(choice: choice!)
        }
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: "id")
        coder.encode(self.title, forKey: "title")
        coder.encode(self.choices, forKey: "choices")
    }

    required init?(coder: NSCoder) {
        self.id = (coder.decodeObject(forKey: "id") as! String)
        self.title = (coder.decodeObject(forKey: "title") as! String)
        self.choices = (coder.decodeObject(forKey: "choices") as! [Choice])
    }

    func isAnsweredCorrect() -> Bool {
        var correct = false

        self.choices?.forEach { choice in
            if choice.selected && choice.correct {
                correct = true
            }
        }

        return correct
    }
}

class Choice: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool = true

    var id: String?
    var title: String?
    var selected: Bool = false
    var correct: Bool = false

    init(choice: GetSubjectQuery.Data.Subject.Question.Choice) {
        self.id = choice.id
        self.title = choice.title
        self.correct = choice.correct ?? false
        self.selected = false
    }

    func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: "id")
        coder.encode(self.title, forKey: "title")
        coder.encode(self.selected, forKey: "selected")
    }

    required init?(coder: NSCoder) {
        self.id = (coder.decodeObject(forKey: "id") as! String)
        self.title = (coder.decodeObject(forKey: "title") as! String)
        self.selected = coder.decodeBool(forKey: "selected")
    }
}
