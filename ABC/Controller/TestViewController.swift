//
//  TestViewController.swift
//  ABC
//
//  Created by iosdevlog on 2019/3/19.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    var delegate: UpdateExam? = nil
    var exam: Exam!
    var index = 0
    var test: Test!
    var alpha: Character = "A"

    @IBOutlet weak var testLbael: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Exam.CURRENT += 1
        self.exam = Exam(index: Exam.CURRENT, wrong: 0, right: 0, tests: [], date: Date())
        updateUI()
    }

    @IBAction func wrong(_ sender: Any) {
        self.exam.wrong += 1
        self.test = Test(char: alpha, isRight: false)
        self.exam.tests.append(self.test)
        checkFinish()
        updateUI()
    }
    
    @IBAction func right(_ sender: Any) {
        self.exam.right += 1
        self.test = Test(char: alpha, isRight: true)
        self.exam.tests.append(self.test)
        checkFinish()
        updateUI()
    }
    
    func updateUI() {
        self.index += 1
        self.alpha = randomCharacter()
        self.title = "\(index)/\(Exam.TOTAL)"
        self.testLbael.text = "\(alpha)"
    }
    
    func checkFinish() {
        if index == Exam.TOTAL {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func randomCharacter() -> Character {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return letters.randomElement()!
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.update(exam: exam)
    }
}

protocol UpdateExam {
    func update(exam: Exam)
}
