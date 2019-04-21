//
//  SG_Mobile_UsageUITests.swift
//  SG Mobile UsageUITests
//
//  Created by Himal Madhushan on 4/17/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import XCTest
//@testable import SG_Mobile_Usage

class SG_Mobile_UsageUITests: XCTestCase {

//    var network: HMNetworking?
    
    override func setUp() {
        continueAfterFailure = false
//        network = HMNetworking.shared
        XCUIApplication().launch()
    }

    func testVolumeDecreasedButtonTap() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["11.453192"].swipeUp()
        tablesQuery.cells.containing(.staticText, identifier:"2013").buttons["chart"].tap()
        let alert = app.alerts["Year: 2013"]
        alert.buttons["OK"].tap()
        XCTAssertNotNil(alert)
        
    }
    
    func testVolumeDecreasedButtonInvisible() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        XCTAssertFalse(tablesQuery.cells.containing(.staticText, identifier:"2004").buttons["chart"].exists)
    }
    
    func testFirstCell() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        XCTAssertTrue(tablesQuery.staticTexts["0.000927"].exists)
    }
    
    func testBackgroundViewHasRoundedConers() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        XCTAssertFalse(tablesQuery.cells.containing(.any, identifier: "UsageCellContainerRoundedView").element.exists)
    }
    
    func testDataLoadingFailure() {
//        let mock = MockSession()
//        mock.data = nil
//        mock.response = nil
//        mock.error = ErrorParser.parsed("Test case failure", errorCode: 0)
//
//        network?.reachabilityManager = reachability(true)
//        network?.urlSession = mock
        
//        let urlRequest = URLRequest.init(url: URL(string: "testUrl")!,
//                                         cachePolicy: .useProtocolCachePolicy,
//                                         timeoutInterval:20.0)
//
//        URLSession.shared.dataTask(with: urlRequest)
//
//        let app = XCUIApplication()
//        let alert = app.alerts["Sorry!"]
//        alert.buttons["OK"].tap()
    }
    
//    func reachability(_ isReachable: Bool) -> ReachabilityMock {
//        let rMock = ReachabilityMock.forInternetConnection() as! ReachabilityMock
//        rMock.reachableWifi = isReachable
//        rMock.reachableWWAN = isReachable
//        return rMock
//    }
}
