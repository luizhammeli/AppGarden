//
//  MainQueueDispatchDecoratorTests.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 25/08/23.
//

import XCTest
@testable import AppGarden

final class MainQueueDispatchDecoratorTests: XCTestCase {
    func test_dispatch_shouldCompleteInMainThread() {
        let sut = makeSUT()
        let exp = expectation(description: #function)
        sut.dispatch {
            XCTAssertTrue(Thread.isMainThread)
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
    }

    func test_dispatch_shouldCompleteInMainThreadWithGlobalQueueExecution() {
        let sut = makeSUT()
        let exp = expectation(description: #function)
        DispatchQueue.global().async {
            sut.dispatch {
                XCTAssertTrue(Thread.isMainThread)
                exp.fulfill()
            }
        }

        wait(for: [exp], timeout: 1)
    }
}

private extension MainQueueDispatchDecoratorTests {
    func makeSUT() -> MainQueueDispatchDecorator<TestClass> {
        let sut = MainQueueDispatchDecorator(instance: TestClass())

        trackForMemoryLeak(for: sut)

        return sut
    }
}

final class TestClass {

}
