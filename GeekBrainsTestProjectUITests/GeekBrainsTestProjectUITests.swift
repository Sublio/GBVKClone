//
//  GeekBrainsTestProjectUITests.swift
//  GeekBrainsTestProjectUITests
//
//  Created by Denis Mordvinov on 27.03.2021.
//

import XCTest

class GeekBrainsTestProjectUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    override func setUp() {
        let app = XCUIApplication()
        app.launch()
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
    }

//    func testVkButtonIsPresent() {
//        let app = XCUIApplication()
//        app.launchEnvironment["resetUserDefaults"] = "true"
//        app.terminate()
//        app.launch()
//        XCTAssertTrue(app.buttons["vk logo icon"].exists)
//        XCTAssertTrue(app.buttons["vk logo icon"].isHittable)
//        XCTAssertTrue(app.buttons["vk logo icon"].isEnabled)
//    }
}
