//
//  XCTestCase+MemoryLeak.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 25/08/23.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeak(for instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
}
