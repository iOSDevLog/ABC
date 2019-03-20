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
    var letter: String = "A"
    let allLetters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let upperLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    let lowerLetters = "abcdefghijklmnopqrstuvwxyz"
    let numberLetters = "0123456789"
    var letters = ""

    @IBOutlet weak var testLbael: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        letters = allLetters
        Exam.CURRENT += 1
        self.exam = Exam(index: Exam.CURRENT, wrong: 0, right: 0, tests: [], date: Date())
        updateUI()
    }

    @IBAction func wrong(_ sender: Any) {
        self.exam.wrong += 1
        self.test = Test(char: letter, isRight: false)
        self.exam.tests.append(self.test)
        checkFinish()
        updateUI()
    }
    
    @IBAction func right(_ sender: Any) {
        self.exam.right += 1
        self.test = Test(char: letter, isRight: true)
        self.exam.tests.append(self.test)
        checkFinish()
        updateUI()
    }
    
    @IBAction func changeType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            letters = allLetters
        case 1:
            letters = upperLetters
        case 2:
            letters = lowerLetters
        case 3:
            letters = numberLetters
        default:
            letters = allLetters
        }

        self.index -= 1
        self.updateUI()
    }

    func updateUI() {
        self.index += 1
        self.letter = randomCharacter()
        self.title = "\(index)/\(Exam.TOTAL)"
        self.testLbael.text = letter
    }
    
    func checkFinish() {
        if index == Exam.TOTAL {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func randomCharacter() -> String {
        return String(letters.randomElement()!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.update(exam: exam)
    }
}

protocol UpdateExam {
    func update(exam: Exam)
}
