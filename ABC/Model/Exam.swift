//
//  Exam.swift
//  ABC
//
//  Created by iosdevlog on 2019/3/19.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import Foundation

struct Exam {
    static let TOTAL = 10
    static var CURRENT = 0
    var index: Int
    var wrong: Int
    var right: Int
    var tests: [Test] = []
    var date: Date
}
