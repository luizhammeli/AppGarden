//
//  DateFormatterExtensionTests.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 25/08/23.
//

import XCTest
@testable import AppGarden

final class DateFormatterExtensionTests: XCTestCase {
    func test_formatToDefault_shouldReturnCorrectValue() {
        let date = Date.makeFakeDate(strDate: "24/08/2023")

        XCTAssertEqual(date.formatToDefault(), "08/24/2023")
    }
}
