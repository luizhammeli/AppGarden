//
//  HTMLSizeMapperTests.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 25/08/23.
//

import XCTest
@testable import AppGarden

final class HTMLSizeMapperTests: XCTestCase {
    func test_map_shouldReturnCorrectSize() {
        let size = HTMLSizeMapper.map(description: makeFakeDescription())
        XCTAssertEqual(size, CGSize(width: 240, height: 162))
    }

    func test_map_shouldReturnThresholdSizeForInvalidHTML() {
        let fakeDescription = "<a href=\"https://www.flickr.com/people/136121443@N06\">el-liza</a>"
        let thresholdValue: CGFloat = 100
        let size = HTMLSizeMapper.map(description: fakeDescription, thresholdValue: thresholdValue)
        XCTAssertEqual(size, CGSize(width: thresholdValue, height: thresholdValue))
    }

    func test_map_shouldReturnDefaultSizeForEmptyHTML() {
        let size = HTMLSizeMapper.map(description: String())
        XCTAssertEqual(size, CGSize(width: 240, height: 240))
    }
}

private extension HTMLSizeMapperTests {
    private func makeFakeDescription() -> String {
        return "<p><a href=\"https://www.flickr.com/people/136121443@N06\">el-liza</a> posted a photo:</p> <p><a href=\"https://www.flickr.com/photos/136121443@N06/53129578020/\" title=\"Porcupine\"><img src=\"https://live.staticflickr.com/65535/53129578020_15483c0b4a_m.jpg\" width=\"240\" height=\"162\" alt=\"Porcupine\" /></a></p> <p>OLYMPUS DIGITAL CAMERA</p>"
    }
}
