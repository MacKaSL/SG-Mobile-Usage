//
//  QuarterUsage.swift
//  SG Mobile Usage
//
//  Created by Himal Madhushan on 4/19/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import Foundation

struct QuarterUsage {
    
    private(set) var mobileDataVolume: Double, quarter: String, year: Int8, id: Int
    
    init(id: Int, year: Int8, quarter: String, volume: Double) {
        self.id = id
        self.mobileDataVolume = volume
        self.year = year
        self.quarter = quarter
    }
    
    init(json: [String: Any]) {
        let id = json[Constants.JSONKey.id] as? Int ?? -1
        let dataVolume = Double(json[Constants.JSONKey.volume] as? String ?? "0.0")!
        var year: Int8 = 0
        var quarter = ""
        
        if let quarterStr = json[Constants.JSONKey.quarter] as? String {
            let components = quarterStr.split(separator: "-")
            if(components.count == 2) {
                year = Int8(components.first ?? "0") ?? Int8(0)
                quarter = String(components.last ?? "")
            }
        }
        
        self.init(id: id, year: year, quarter: quarter, volume: dataVolume)
    }
}
