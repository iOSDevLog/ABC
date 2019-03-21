//
//  String+Localization.swift
//  ABC
//
//  Created by iosdevlog on 2019/3/21.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
