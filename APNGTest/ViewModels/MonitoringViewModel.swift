//
//  MonitoringViewModel.swift
//  APNGTest
//
//  Created by Erik Hede on 2019-04-03.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import Foundation

struct MonitoringViewModel {
    private let monitoring: Monitoring
    
    init(monitoring: Monitoring) {
        self.monitoring = monitoring
    }
}

extension MonitoringViewModel {
    var cpuString: String {
        return self.monitoring.cpu.formatAsPecentage
    }
    var memoryString: String {
        return self.monitoring.memory.formatAsMb
    }
}
