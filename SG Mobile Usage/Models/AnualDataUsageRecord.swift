//
//  AnualDataUsageRecord.swift
//  SG Mobile Usage
//
//  Created by Himal Madhushan on 4/19/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import Foundation

struct AnualDataUsageRecord {
    var year: Int, total: Double, hasDecreased = false
    var decreasedQuarters: [String]
    var quarterUsages = [QuarterUsage]()
    
    init(year: Int, lastQuarter: QuarterUsage?, quarterUsages: [QuarterUsage]) throws {
        
        // Check if there is at least 1 quarter usage detail
        guard quarterUsages.count > 0 else {
            throw DataUsageError.invalidNumberOfQuaters
        }
        
        self.year = year
        self.quarterUsages = quarterUsages
        self.decreasedQuarters = [String]()
        self.hasDecreased = false
        self.total = 0.0
        
        var lastQuarter = lastQuarter
        
        for usage in quarterUsages {
            
            // Adding all quarter usages into anual total
            self.total += usage.mobileDataVolume
            
            if let lq = lastQuarter, lq.mobileDataVolume > usage.mobileDataVolume {
                self.hasDecreased = true
                self.decreasedQuarters.append(usage.quarter)
            }
            lastQuarter = usage
        }
    }
}
