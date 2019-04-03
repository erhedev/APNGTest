//
//  Double+Extension.swift
//  APNGTest
//
//  Created by Erik Hede on 2019-04-03.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import Foundation

extension Double {
    var formatAsPecentage: String {
        return String(format: "%.0f°", self) + " %"
    }
}

