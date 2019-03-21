//
//  TestViewController.swift
//  ABC
//
//  Created by iosdevlog on 2019/3/19.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    enum LearningType {
        case train
        case test
    }
    var learnType = LearningType.train
    var delegate: UpdateExam? = nil
    var exam: Exam!
    var index = 0
    var test: Test!
    var letter: String = "A"
    var letters = ""
    
    @IBOutlet weak var testLbael: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        letters = allLetters
        Exam.CURRENT += 1
        self.exam = Exam(index: Exam.CURRENT, wrong: 0, right: 0, tests: [], date: Date())
        updateUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        speech(letter: self.letter)
    }

    @IBAction func wrong(_ sender: Any) {
        self.exam.wrong += 1
        self.test = Test(letter: letter, isRight: false)
        self.exam.tests.append(self.test)
        checkFinish()
        updateUI()
    }
    
    @IBAction func right(_ sender: Any) {
        self.exam.right += 1
        self.test = Test(letter: letter, isRight: true)
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
        
        var letter = randomCharacter()
        
        while letter == self.letter {
            letter = randomCharacter()
        }
        
        self.letter = letter
        switch learnType {
        case .train:
            self.navigationItem.title = "Train".localized + " \(self.exam.right)/\(index-1)"
            speech(letter: self.letter, detail: true)
            break
        case .test:
            self.navigationItem.title = "Test".localized + "\(index)/\(Exam.TOTAL)"
            break
        }
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
