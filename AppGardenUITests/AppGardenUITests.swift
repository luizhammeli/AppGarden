//
//  AppGardenUITests.swift
//  AppGardenUITests
//
//  Created by Luiz Diniz Hammerli on 23/08/23.
//

 import XCTest

 final class AppGardenUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Simple test to validate with the network the entire app flow, as a alternative we can mock our http client to return the fake data or create some test api to return always the same result. The ideia of this test is just show an example of a End to End test, testing the integration between all layers.
    func test_search_validateTheSearchAndDetailFlow() {
        let app = XCUIApplication()
        app.launch()
        
        let searchBar = app.searchFields["Buscar"]
        
        searchBar.tap()
        searchBar.typeText("Car")
        
        sleep(5)
        
        app.cells.firstMatch.tap()
        
        XCTAssertEqual(app.firstMatch.images.count, 1)
        XCTAssertTrue(app.firstMatch.staticTexts.count >= 4)
    }
 }
