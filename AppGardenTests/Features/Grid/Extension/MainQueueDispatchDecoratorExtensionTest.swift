//
//  MainQueueDispatchDecoratorExtensionTest.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 25/08/23.
//

import XCTest
@testable import AppGarden

final class MainQueueDispatchDecoratorExtensionTest: XCTestCase {
    func test_search_shouldSendCorrectData() {
        let query = "test"
        let (sut, spy) = makeSUT()

        sut.search(query: query) { _ in }

        XCTAssertEqual(spy.queries, [query])
    }

    func test_search_shouldCompleteWithCorrectData() {
        var receivedResult: LoadSearchItems.Result?
        let (sut, spy) = makeSUT()

        sut.search(query: String()) { receivedResult = $0 }
        spy.complete(with: .success([]))

        XCTAssertEqual(receivedResult, .success([]))
    }
}

private extension MainQueueDispatchDecoratorExtensionTest {
    func makeSUT() -> (MainQueueDispatchDecorator<LoadSearchItemsSpy>, LoadSearchItemsSpy) {
        let spy = LoadSearchItemsSpy()
        let sut = MainQueueDispatchDecorator(instance: spy)

        trackForMemoryLeak(for: sut)
        trackForMemoryLeak(for: spy)

        return (sut, spy)
    }
}
