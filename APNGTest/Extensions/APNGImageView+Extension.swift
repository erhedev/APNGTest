//
//  APNGImageView+Extension.swift
//  APNGTest
//
//  Created by Erik Hede on 2019-04-03.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import Foundation
import APNGKit

extension APNGImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = APNGImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
