//
//  DataUsageRecord.swift
//  SG Mobile Usage
//
//  Created by Himal Madhushan on 4/18/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import Foundation

struct DataUsageResponseHandler {
    
    private var quarterUsages = [QuarterUsage]()
    var anualUsage = [AnualDataUsageRecord]()
    
    init(_ json: [String:Any]) throws {
        
        var lastQuarter: QuarterUsage?
        
        // Getting records
        if let dataUsages = json[Constants.JSONKey.records] as? [[String: Any]] {
            for usage in dataUsages {
                quarterUsages.append(QuarterUsage.init(json: usage))
            }
            
            // Getting all unique years to calculate anual usage
            let years = Set(quarterUsages.map { $0.year }).sorted()
            for year in years {
                // Grouping by year
                let filteredQuaters = quarterUsages.filter {$0.year == year}.sorted {
                    $0.quarter < $1.quarter
                }
                do {
                    let annualDataUsage = try AnualDataUsageRecord.init(year: year, lastQuarter: lastQuarter, quarterUsages: filteredQuaters)
                    self.anualUsage.append(annualDataUsage)
                    lastQuarter = filteredQuaters.last
                } catch {
                    print("Annual data usage creation skipped.")
                }
            }
        } else {
            throw DataUsageError.invalidJSON
        }
    }
}



