//
//  SystemUsageInfo.swift
//  APNGTest
//
//  Created by Erik Hede on 2019-04-01.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import Foundation

struct SystemUsageInfo {
    
    func hostCPULoadInfo() -> Double? {
        let HOST_CPU_LOAD_INFO_COUNT = MemoryLayout<host_cpu_load_info>.stride/MemoryLayout<integer_t>.stride
        var size = mach_msg_type_number_t(HOST_CPU_LOAD_INFO_COUNT)
        var cpuLoadInfo = host_cpu_load_info()
        
        let result = withUnsafeMutablePointer(to: &cpuLoadInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: HOST_CPU_LOAD_INFO_COUNT) {
                host_statistics(mach_host_self(), HOST_CPU_LOAD_INFO, $0, &size)
            }
        }
        
        let totalTicks = cpuLoadInfo.cpu_ticks.0 + cpuLoadInfo.cpu_ticks.1 + cpuLoadInfo.cpu_ticks.2 + cpuLoadInfo.cpu_ticks.3
        
        let sys = Double(cpuLoadInfo.cpu_ticks.0) / Double(totalTicks) * 100
        
        if result != KERN_SUCCESS{
            print("Error  - \(#file): \(#function) - kern_result_t = \(result)")
            return nil
        }
        return sys
    }
    
    func report_memory() -> Int? {
        var taskInfo = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size)/4
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &taskInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count)
            }
        }
        
        if kerr == KERN_SUCCESS {
            print("Memory used in bytes: \(taskInfo.resident_size)")
            return Int(taskInfo.resident_size)
        }
        else {
            print("Error with task_info(): " +
                (String(cString: mach_error_string(kerr), encoding: String.Encoding.ascii) ?? "unknown error"))
            return nil
        }
    }
}
