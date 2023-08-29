//
//  DefaultThrottlerTests.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 29/08/23.
//

import XCTest
@testable import AppGarden

final class DefaultThrottlerTest: XCTestCase {
    func test_throttle_shouldComplete() {
        let sut = makeSUT()
        var didComplete: Bool = false
        
        let exp = expectation(description: #function)
        
        sut.throttle {
            didComplete = true
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        
        XCTAssertTrue(didComplete)
    }
    
    func test_throttle_shouldCancelFirstBlock() {
        let sut = makeSUT(delay: 0.5)
        var didCompleteFirst: Bool = false
        var didCompleteSecond: Bool = false
        
        let exp = expectation(description: #function)
        
        sut.throttle {
            didCompleteFirst = true
            exp.fulfill()
        }
        
        sut.throttle {
            didCompleteSecond = true
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 2)
        
        XCTAssertTrue(didCompleteSecond)
        XCTAssertFalse(didCompleteFirst)
    }
}

private extension DefaultThrottlerTest {
    func makeSUT(delay: TimeInterval = 0) -> DefaultThrottler {
        let sut = DefaultThrottler(delay: delay)
        
        trackForMemoryLeak(for: sut)
        
        return sut
    }
}
