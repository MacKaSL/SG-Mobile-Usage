//
//  NetworkTests.swift
//  SG Mobile UsageTests
//
//  Created by Himal Madhushan on 4/20/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import XCTest
@testable import SG_Mobile_Usage

class NetworkTests: XCTestCase {

    var network: HMNetworking?
    
    override func setUp() {
        network = HMNetworking.shared
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUsageURL() {
        let urlStr = APIURL.dataUsage
        XCTAssertEqual(urlStr.completedURL, "https://data.gov.sg/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f", "Wrong API URL")
    }

    func testReachability() {
        let rMock = ReachabilityMock.forInternetConnection() as! ReachabilityMock
        rMock.reachableWifi = false
        rMock.reachableWWAN = false
        
        network?.reachabilityManager = rMock
        
        network?.request(.dataUsage, method: .get, success: { (resp) in
            XCTFail("This server call should be failed when there's no internet connection")
        }, failure: { (error) in
            XCTAssertNotNil(error, "There should be an error when API call is failed")
        })
    }
    
    func testInvalidResponseJSON() {
        
    }
}
