//
//  TinkTinkUITests.swift
//  TinkTinkUITests
//
//  Created by Анастасия Леонтьева on 03.12.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

//import FBSnapshotTestCase
import XCTest
import Foundation

class TinkTinkUITests: XCTestCase {
    
  func testCheckProfileFields() throws {
    // UI tests must launch the application that they test.
    let app = XCUIApplication()
    app.launch()
    app.navigationBars["Tinkoff chat"].otherElements["avatar"].tap()
    app.buttons["Edit"].tap()
    app.textFields["Username"].tap()
    _ = app.waitForExistence(timeout: 3)
    app.textViews["bio"].tap()
    _ = app.waitForExistence(timeout: 2)
    app.buttons["Edit"].tap()
        
    XCTAssertEqual(app.textFields["Username"].label, "")
    XCTAssertEqual(app.textViews["bio"].label, "")
    XCTAssertEqual(app.textFields.count + app.textViews.count, 2)
  }
}
