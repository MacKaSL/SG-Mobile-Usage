//
//  AnualDataUsageRecord.swift
//  SG Mobile Usage
//
//  Created by Himal Madhushan on 4/19/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import RealmSwift

class AnualDataUsageRecord: Object {
    
    @objc dynamic var year: Int = 0
    @objc dynamic var total: Double = 0.0
    @objc dynamic var hasDecreased: Bool = false
    var decreasedQuarters = List<String>()
    var quarterUsages = List<QuarterUsage>()
    
//    var decreasedQuarters: [String] = []
//    var quarterUsages = [QuarterUsage]()
    
    override static func primaryKey() -> String? {
        return "year"
    }
    
    required convenience init(year: Int, lastQuarter: QuarterUsage?, quarterUsages: [QuarterUsage]) throws {
        
        // Check if there is at least 1 quarter usage detail
        guard quarterUsages.count > 0 else {
            throw DataUsageError.invalidNumberOfQuaters
        }
        
        self.init()
        
        self.year = year
        self.quarterUsages.append(objectsIn: quarterUsages)
        
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
        
        try? RealmManager.save(self)
    }
}
