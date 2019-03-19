//
//  Exam.swift
//  ABC
//
//  Created by iosdevlog on 2019/3/19.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import Disk

struct Exam: Codable {
    static let TOTAL = 100
    static var CURRENT = 0
    var index: Int
    var wrong: Int
    var right: Int
    var tests: [Test] = []
    var date: Date
}
