//
//  QuarterUsage.swift
//  SG Mobile Usage
//
//  Created by Himal Madhushan on 4/19/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import RealmSwift

class QuarterUsage: Object {
    
    @objc dynamic var mobileDataVolume: Double = 0.0
    @objc dynamic var quarter: String = ""
    @objc dynamic var year: Int = 0
    @objc dynamic var id: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init(id: Int, year: Int, quarter: String, volume: Double) {
        self.init()
        
        self.id = id
        self.mobileDataVolume = volume
        self.year = year
        self.quarter = quarter
        
        try? RealmManager.save(self)
    }
    
    required convenience init(json: [String: Any]) {
        let id = json[Constants.JSONKey.id] as? Int ?? -1
        let dataVolume = Double(json[Constants.JSONKey.volume] as? String ?? "0.0")!
        var year: Int = 0
        var quarter = ""
        
        if let quarterStr = json[Constants.JSONKey.quarter] as? String {
            let components = quarterStr.split(separator: "-")
            if(components.count == 2) {
                year = Int(components.first ?? "0") ?? 0
                quarter = String(components.last ?? "")
            }
        }
        
        self.init(id: id, year: year, quarter: quarter, volume: dataVolume)
    }
}
