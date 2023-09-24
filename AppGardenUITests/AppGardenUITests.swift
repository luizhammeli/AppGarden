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
        let app = makeSearch(query: "Car")
        sleep(4)
        
        app.cells.firstMatch.tap()
        
        XCTAssertEqual(app.firstMatch.images.count, 1)
        XCTAssertTrue(app.firstMatch.staticTexts.count >= 4)
        app.navigationBars["Details"].buttons["App Garden"].tap()
    }
    
    func test_detail_validateShareButton() {
        let app = makeSearch(query: "Car")
        sleep(4)
        
        app.cells.firstMatch.tap()
            
        app.navigationBars["Details"].buttons["Share"].tap()
        app.collectionViews.scrollViews.element.swipeUp()
        app.collectionViews.scrollViews.element.swipeDown()
    }
    
    func test_search_validateTheSearchErrorFlow() {
        let app = makeSearch(query: "Car980923-@@")
        sleep(4)
        
        XCTAssertEqual(app.cells.count, 0)
        XCTAssertEqual(app.firstMatch.staticTexts.count, 3)
    }
}

private extension AppGardenUITests {
    func makeSearch(query: String) -> XCUIApplication {
        let app = XCUIApplication()
        app.launch()
        
        let searchBar = app.searchFields["Search"]
        
        searchBar.tap()
        searchBar.typeText(query)
        
        return app
    }
}
