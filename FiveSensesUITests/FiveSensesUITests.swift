//
//  FiveSensesUITests.swift
//  FiveSensesUITests
//
//  Created by Luis Ezcurdia on 10/19/18.
//  Copyright © 2018 fi.unam.mx. All rights reserved.
//

import XCTest

class FiveSensesUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        setupSnapshot(app)
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    func testTabBar() {
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Acelerometer"].tap()
        snapshot("0-Acelerometer")
        tabBarsQuery.buttons["Gyroscope"].tap()
        snapshot("1-Gyroscope")
        tabBarsQuery.buttons["Compas"].tap()
        snapshot("2-Compas")
        tabBarsQuery.buttons["Location"].tap()
        snapshot("3-Location")
        tabBarsQuery.buttons["Maps"].tap()
        snapshot("4-Maps")
    }
}
