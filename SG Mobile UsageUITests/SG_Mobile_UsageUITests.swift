//
//  SG_Mobile_UsageUITests.swift
//  SG Mobile UsageUITests
//
//  Created by Himal Madhushan on 4/17/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import XCTest

class SG_Mobile_UsageUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
//        tablesQuery.staticTexts["11.453192"].swipeUp()
        XCTAssertFalse(tablesQuery.cells.containing(.staticText, identifier:"2004").buttons["chart"].exists)
    }
    
    func testFirstCell() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        XCTAssertTrue(tablesQuery.staticTexts["0.000927"].exists)
    }
}
