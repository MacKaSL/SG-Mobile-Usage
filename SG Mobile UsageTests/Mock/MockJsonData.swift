//
//  MockData.swift
//  SG Mobile UsageTests
//
//  Created by Himal Madhushan on 4/19/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import Foundation

struct MockJsonData {
    
    static func quarterUsage() -> [String: Any] {
        return ["volume_of_mobile_data": "10.96733",
        "quarter": "2016-Q1",
        "_id": 47]
    }
    
    static func quarterUsageNoQuarterDetails() -> [String: Any] {
        return ["volume_of_mobile_data": "10.96733",
                "quarter": "-",
                "_id": 47]
    }
    
    static func quarterUsageNoYear() -> [String: Any] {
        return ["volume_of_mobile_data": "10.96733",
                "quarter": "-Q1",
                "_id": 47]
    }
    
    static func quarterUsageEmptyQuarterDetails() -> [String: Any] {
        return ["volume_of_mobile_data": "10.96733",
                "quarter": "",
                "_id": 47]
    }
    
    static func quarterUsageNoHyphanInQuarterDetails() -> [String: Any] {
        return ["volume_of_mobile_data": "10.96733",
                "quarter": "2016Q1",
                "_id": 47]
    }
    
    static func quarterUsageEmptyVolumeData() -> [String: Any] {
        return ["volume_of_mobile_data": "",
                "quarter": "",
                "_id": 47]
    }
    
    static func quarterUsagesArray() -> [[String: Any]] {
        return [["volume_of_mobile_data": "0.000384",
                 "quarter": "2004-Q3",
                 "_id": 1],
                ["volume_of_mobile_data": "0.000543",
                 "quarter": "2004-Q4",
                 "_id": 2],
                ["volume_of_mobile_data": "0.00062",
                 "quarter": "2005-Q1",
                 "_id": 3],
                ["volume_of_mobile_data": "0.000634",
                 "quarter": "2005-Q2",
                 "_id": 4],
                ["volume_of_mobile_data": "0.001189",
                 "quarter": "2006-Q2",
                 "_id": 5],
                ["volume_of_mobile_data": "0.001735",
                 "quarter": "2006-Q3",
                 "_id": 6],
                ["volume_of_mobile_data": "0.003323",
                 "quarter": "2006-Q4",
                 "_id": 7]]
    }
    
    static func emptyDictionaryArray() -> [[String: Any]] {
        return [[:]]
    }
    
    static func fullJson() -> [String: Any] {
        return ["help": "https://data.gov.sg/api/3/action/help_show?name=datastore_search",
        "success": true,
        "result":["resource_id": "a807b7ab-6cad-4aa6-87d0-e283a7353a0f",
                  "fields": [["type": "int4", "id": "_id"], ["type": "text", "id": "quarter"], ["type": "numeric", "id": "volume_of_mobile_data"]],
                  "records": [["volume_of_mobile_data": "0.000384",
                         "quarter": "2004-Q3",
                         "_id": 1],
                        ["volume_of_mobile_data": "0.000543",
                         "quarter": "2004-Q4",
                         "_id": 2],
                        ["volume_of_mobile_data": "0.00062",
                         "quarter": "2005-Q1",
                         "_id": 3],
                        ["volume_of_mobile_data": "0.000634",
                         "quarter": "2005-Q2",
                         "_id": 4],
                        ["volume_of_mobile_data": "0.001189",
                         "quarter": "2006-Q2",
                         "_id": 5],
                        ["volume_of_mobile_data": "0.001735",
                         "quarter": "2006-Q3",
                         "_id": 6],
                        ["volume_of_mobile_data": "0.003323",
                         "quarter": "2006-Q4",
                         "_id": 7]],
                  "_links": ["start": "/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f",
                             "next": "/api/action/datastore_search?offset=100&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"],
                  "total": 56 ]]
    }
    
}
