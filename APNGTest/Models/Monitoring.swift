//
//  Monitoring.swift
//  APNGTest
//
//  Created by Erik Hede on 2019-04-03.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import Foundation

struct Monitoring {
    
    var systemInfo: SystemUsageInfo
    
    var memory: Int = 0
    var cpu: Double = 0.0
    
    init() {
        systemInfo = SystemUsageInfo()
        if let memory = systemInfo.report_memory() {
            self.memory = memory
        }
        if let cpu = systemInfo.hostCPULoadInfo() {
            self.cpu = cpu
        }
    }
    
    mutating func updateMemoryUsage() {
        if let memory = systemInfo.report_memory() {
            self.memory = memory
        }
    }
    
    mutating func updateCpuUsage() {
        if let cpu = systemInfo.hostCPULoadInfo() {
            self.cpu = cpu
        }
    }
    
}


