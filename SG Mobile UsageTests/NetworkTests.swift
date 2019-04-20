//
//  NetworkTests.swift
//  SG Mobile UsageTests
//
//  Created by Himal Madhushan on 4/20/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import XCTest
import Reachability
@testable import SG_Mobile_Usage

class NetworkTests: XCTestCase {

    var network: HMNetworking?
    
    override func setUp() {
        network = HMNetworking.shared
    }
    
    override func tearDown() {
        network?.urlSession = URLSession.shared
        network?.reachabilityManager = Reachability.forInternetConnection()
    }

    func testUsageURL() {
        let urlStr = APIURL.dataUsage
        XCTAssertEqual(urlStr.completedURL, "https://data.gov.sg/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f", "Wrong API URL")
    }

    func testReachability() {
        network?.reachabilityManager = reachability(false)
        network?.request(.dataUsage, method: .get, success: { (resp) in
            XCTFail("This server call should be failed when there's no internet connection")
        }, failure: { (error) in
            XCTAssertNotNil(error, "There should be an error when API call is failed")
        })
    }
    
    func testInvalidResponseJSON() {
        let mock = MockSession()
        mock.data = "<html></html>".data(using: .utf8)
        mock.response = HTTPURLResponse(url: URL(string: APIURL.invalid.completedURL)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        mock.error = nil
        
        network?.reachabilityManager = reachability(true)
        network?.urlSession = mock
        
        network?.request(.dataUsage, method: .get, success: { (resp) in
            XCTFail("Cannot get called when there is a failure")
        }, failure: { (error) in
            XCTAssertEqual(error?.code, Constants.ErrorCode.parsingFailed, "Invalid json parsing should be failed")
        })
    }
    
    func testServerError() {
        let mock = MockSession()
        mock.data = "<html></html>".data(using: .utf8)
        mock.response = HTTPURLResponse(url: URL(string: APIURL.invalid.completedURL)!, statusCode: 500, httpVersion: nil, headerFields: nil)
        mock.error = nil
        
        network?.reachabilityManager = reachability(true)
        network?.urlSession = mock
        
        network?.request(.dataUsage, method: .get, success: { (resp) in
            XCTFail("Cannot get called when there is a failure")
        }, failure: { (error) in
            XCTAssertEqual(error?.code, 500, "Should be failed when server has error")
        })
    }
    
    func testNoResponseFromServer() {
        let mock = MockSession()
        mock.data = "<html></html>".data(using: .utf8)
        mock.response = nil
        mock.error = nil
        
        network?.reachabilityManager = reachability(true)
        network?.urlSession = mock
        
        network?.request(.dataUsage, method: .get, success: { (resp) in
            XCTFail("Cannot get called when there is a failure")
        }, failure: { (error) in
            XCTAssertEqual(error?.code, Constants.ErrorCode.noResponse, "Should be failed when there is no response from server")
        })
    }
    
    func testRequestError() {
        let mock = MockSession()
        mock.data = nil
        mock.response = nil
        mock.error = ErrorParser.parsed("Test case failure", errorCode: 0)
        
        network?.reachabilityManager = reachability(true)
        network?.urlSession = mock
        
        network?.request(.dataUsage, method: .get, success: { (resp) in
            XCTFail("Cannot get called when there is a failure")
        }, failure: { (error) in
            XCTAssertEqual(error?.code, Constants.ErrorCode.sessionFailed, "Should be failed when there is error from server")
            XCTAssertNotEqual(error?.code, -1)
        })
    }
    
    func testJsonParsingFailure() {
        let mock = MockSession()
        mock.data = try? JSONSerialization.data(withJSONObject: MockJsonData.fullJsonWithoutRecords(), options: .prettyPrinted)
        mock.response = HTTPURLResponse(url: URL(string: APIURL.invalid.completedURL)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        mock.error = nil
        
        network?.reachabilityManager = reachability(true)
        network?.urlSession = mock
        
        HMNetworkManager.fetchDataUsage(success: { (records) in
            XCTFail("Cannot get called when there is a failure")
        }) { (error) in
            XCTAssertEqual(error?.code, Constants.ErrorCode.noRecordsFoundInJson, "Should be failed when json doesn't contain 'records' key")
            XCTAssertNotEqual(error?.code, -1)
        }
    }
    
    func testNetworkManagerNoResponse() {
        let mock = MockSession()
        mock.data = nil
        mock.response = nil //HTTPURLResponse(url: URL(string: APIURL.invalid.completedURL)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        mock.error = ErrorParser.parsed("Test case failure", errorCode: 0)
        
        network?.reachabilityManager = reachability(true)
        network?.urlSession = mock
        
        HMNetworkManager.fetchDataUsage(success: { (records) in
            XCTFail("Cannot get called when there is a failure")
        }) { (error) in
            XCTAssertEqual(error?.code, Constants.ErrorCode.sessionFailed, "Should be failed when there is error from server")
            XCTAssertNotEqual(error?.code, -1)
        }
    }
    
    func reachability(_ isReachable: Bool) -> ReachabilityMock {
        let rMock = ReachabilityMock.forInternetConnection() as! ReachabilityMock
        rMock.reachableWifi = isReachable
        rMock.reachableWWAN = isReachable
        return rMock
    }
}
