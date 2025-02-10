//
//  Untitled.swift
//  FakeCoolBlue
//
//  Created by Clinton on 10/02/2025.
//

import XCTest
@testable import FakeCoolBlue


class FakeCoolBlueeUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }

    func testSearchBoxInteraction() throws {
        let productList = app.tables

        let magnifyingGlass = app.images["magnifyingglass"]

        let textField = app.textFields["Search..."]
        XCTAssertFalse(textField.exists)

        magnifyingGlass.tap()

        XCTAssertTrue(textField.waitForExistence(timeout: 1))


        textField.tap()
        textField.typeText("Product search")


        XCTAssertEqual(textField.value as? String, "Product search")
    }
}
