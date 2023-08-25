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
        let date = makeFakeDate(strDate: "24/08/2023")

        XCTAssertEqual(date.formatToDefault(), "08/24/2023")
    }
}

private extension DateFormatterExtensionTests {
    func makeFakeDate(strDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.date(from: strDate) ?? Date()
    }
}
