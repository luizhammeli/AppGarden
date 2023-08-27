//
//  SearchImageLayoutDataSourceTests.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 26/08/23.
//

import XCTest
@testable import AppGarden

final class SearchImageLayoutDataSourceTests: XCTestCase {
    func test_cellSize_shouldReturnCorrectValueForPortraitOrientation() {
        let sut = SearchImageLayoutDataSource()

        XCTAssertEqual(sut.cellSize(width: 102, verticalSize: .regular), CGSize(width: 32, height: 32))
    }

    func test_cellSize_shouldReturnCorrectValueForLandscapeOrientation() {
        let sut = SearchImageLayoutDataSource()

        XCTAssertEqual(sut.cellSize(width: 102, verticalSize: .compact), CGSize(width: 18, height: 18))
    }
}
