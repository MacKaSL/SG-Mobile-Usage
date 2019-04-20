//
//  AnualDataUsageRecordTests.swift
//  SG Mobile UsageTests
//
//  Created by Himal Madhushan on 4/19/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import XCTest
@testable import SG_Mobile_Usage

class AnualDataUsageRecordTests: XCTestCase {

    func testEmptyQuarterSetToAnual() {
        XCTAssertThrowsError(try AnualDataUsageRecord.init(year: 2004, lastQuarter: nil, quarterUsages: []))
    }

    func testNumberOfAnualRecords() {
        let json = MockJsonData.fullJson()
        do  {
            if let json = json[Constants.JSONKey.result] as? [String: Any] {
                let responseObj = try DataUsageResponseHandler.init(json)
                XCTAssertEqual(responseObj.anualUsage.count, 3, "Invalid years count")
            }
        } catch {}
    }
    
    func testAnualRecords() {
        let lastQ = QuarterUsage.init(id: 1, year: 2014, quarter: "Q3", volume: 20.6343)
        let q1 = QuarterUsage.init(id: 2, year: 2015, quarter: "Q1", volume: 18.6343)
        let q2 = QuarterUsage.init(id: 3, year: 2015, quarter: "Q2", volume: 18.6343)
        
        var anualRecord: AnualDataUsageRecord!
        do {
            anualRecord = try AnualDataUsageRecord.init(year: 2015, lastQuarter: lastQ, quarterUsages: [q1, q2])
        } catch  { }
        
        XCTAssertEqual(anualRecord.decreasedQuarters.count, 1, "Wrong decreased quarter count")
    }

}
