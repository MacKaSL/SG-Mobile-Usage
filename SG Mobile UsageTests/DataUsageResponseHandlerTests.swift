//
//  DataUsageResponseHandlerTests.swift
//  SG Mobile UsageTests
//
//  Created by Himal Madhushan on 4/19/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import XCTest
@testable import SG_Mobile_Usage

class DataUsageResponseHandlerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testEmptyResponse() {
        let json = [String:Any]()
        XCTAssertThrowsError(try DataUsageResponseHandler.init(json))
    }
    
    func testCompletedResponse() {
        let json = MockJsonData.fullJson()
        do  {
            if let json = json[Constants.JSONKey.result] as? [String: Any] {
                let responseObj = try DataUsageResponseHandler.init(json)
                XCTAssertEqual(responseObj.anualUsage.count, 3, "Invalid years count")
            }
        } catch {}
    }
    
    func testEmptyDictionaryArray() {
        let json = MockJsonData.fullJson()
        
        var quarterUsages = [QuarterUsage]()
        var anualUsage = [AnualDataUsageRecord]()
        
        if let dataUsages = json[Constants.JSONKey.records] as? [[String: Any]] {
            for usage in dataUsages {
                quarterUsages.append(QuarterUsage.init(json: usage))
            }
            
            XCTAssertEqual(quarterUsages.count, 3, "Invalid quarters count")
            
            let years = Set(quarterUsages.map { $0.year }).sorted()
            
            XCTAssertEqual(years.count, 3, "Invalid years count")
            
            for year in years {
                let filteredQuaters = quarterUsages.filter {$0.year == year}.sorted {
                    $0.quarter < $1.quarter
                }
                do {
                    let annualDataUsage = try AnualDataUsageRecord.init(year: year, lastQuarter: nil, quarterUsages: filteredQuaters)
                    anualUsage.append(annualDataUsage)
                    
                    XCTAssertEqual(anualUsage.count, 3, "Invalid number of anual records")
                } catch { }
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
