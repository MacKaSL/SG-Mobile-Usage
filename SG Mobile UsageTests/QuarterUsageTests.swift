//
//  QuarterUsageTests.swift
//  SG Mobile UsageTests
//
//  Created by Himal Madhushan on 4/19/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import XCTest
@testable import SG_Mobile_Usage

class QuarterUsageTests: XCTestCase {
    
    func testQuarterUsage() {
        let mock = MockJsonData.quarterUsageDict()
        let quarter = QuarterUsage.init(json: mock)
        XCTAssertEqual(quarter.id, 47, "Quarter usage id couldn't extract")
        XCTAssertEqual(quarter.mobileDataVolume, 10.96733, "Quarter usage volume_of_mobile_data couldn't extract")
        XCTAssertEqual(quarter.year, 2016, "Quarter usage year couldn't extract")
        XCTAssertEqual(quarter.quarter, "Q1", "Quarter usage quarter couldn't extract")
    }
    
    func testNoQuarterDetails() {
        let mock = MockJsonData.quarterUsageNoQuarterDetails()
        let quarter = QuarterUsage.init(json: mock)
        XCTAssertEqual(quarter.year, 0, "Quarter usage year is getting wrong value")
        XCTAssertEqual(quarter.quarter, "", "Quarter usage quarter is getting wrong value")
    }
    
    func testEmptyQuarterDetails() {
        let mock = MockJsonData.quarterUsageEmptyQuarterDetails()
        let quarter = QuarterUsage.init(json: mock)
        XCTAssertEqual(quarter.year, 0, "Quarter usage year is getting wrong value")
        XCTAssertEqual(quarter.quarter, "", "Quarter usage quarter is getting wrong value")
    }
    
    func testNoHyphanInQuarterDetails() {
        let mock = MockJsonData.quarterUsageNoHyphanInQuarterDetails()
        let quarter = QuarterUsage.init(json: mock)
        XCTAssertEqual(quarter.year, 0, "Quarter usage year is getting wrong value")
        XCTAssertEqual(quarter.quarter, "", "Quarter usage quarter is getting wrong value")
    }
    
    func testEmptyVolumeData() {
        let mock = MockJsonData.quarterUsageEmptyVolumeData()
        let quarter = QuarterUsage.init(json: mock)
        XCTAssertEqual(quarter.mobileDataVolume, 0, "Quarter usage mobileDataVolume is getting wrong value")
    }

}
