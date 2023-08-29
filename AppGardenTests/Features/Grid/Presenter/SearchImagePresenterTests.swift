//
//  SearchImagePresenterTests.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 25/08/23.
//

import XCTest
@testable import AppGarden

final class SearchImagePresenterTests: XCTestCase {
    func test_makeSearch_shouldSendCorrectQueryValue() {
        // Given
        let query = "test"
        let (sut, spy) = makeSUT()

        // When
        sut.makeSearch(query: query)

        // Then
        XCTAssertEqual(spy.queries, [query])
    }

    func test_makeSearch_shouldCompleteWithErrorWithEmpryQuery() {
        // Given
        let delegate = DelegateSpy()
        let (sut, _) = makeSUT(delegate: delegate)

        // When
        sut.makeSearch(query: String())

        // Then
        XCTAssertEqual(delegate.messages, [.error])
    }

    func test_makeSearch_shouldShowLoaderWhenRequestStarted() {
        // Given
        let delegate = DelegateSpy()
        let (sut, _) = makeSUT(delegate: delegate)

        // When
        sut.makeSearch(query: "test")

        // Then
        XCTAssertEqual(delegate.messages, [.loader(isLoading: true)])
    }

    func test_makeSearch_shouldRemoveLoaderWhenRequestFinishedWithError() {
        // Given
        let delegate = DelegateSpy()
        let (sut, spy) = makeSUT(delegate: delegate)

        // When
        sut.makeSearch(query: "test")
        spy.complete(with: .failure(.unexpected))

        // Then
        XCTAssertEqual(delegate.messages, [.loader(isLoading: true), .loader(isLoading: false), .error])
    }

    func test_makeSearch_shouldSetErrorStateIfRequestFinishedWithEmptyData() {
        // Given
        let delegate = DelegateSpy()
        let (sut, spy) = makeSUT(delegate: delegate)

        // When
        sut.makeSearch(query: "test")
        spy.complete(with: .success([]))

        // Then
        XCTAssertEqual(delegate.messages, [.loader(isLoading: true), .loader(isLoading: false), .error])
    }

    func test_makeSearch_shouldSucceedIfRequestFinishedWithValidData() {
        // Given
        let delegate = DelegateSpy()
        let fakeItem = [makeFakeSearchItemResponse()]
        let expectedResult = fakeItem.map { makeFakeSearchImageViewModel(with: $0) }
        let (sut, spy) = makeSUT(delegate: delegate)

        // When
        sut.makeSearch(query: "test")
        spy.complete(with: .success(fakeItem))

        // Then
        XCTAssertEqual(delegate.messages, [.loader(isLoading: true), .loader(isLoading: false), .view(items: expectedResult)])
    }
    
    func test_makeSearch_shouldNotCompleteWithResultIfInstanceHasBeenDealocated() {
        // Given
        let delegate = DelegateSpy()
        let spy = LoadSearchItemsSpy()
        var sut: SearchImagePresenter? = SearchImagePresenter(serchLoader: spy)
        sut?.delegate = delegate

        // When
        sut?.makeSearch(query: "test")
        sut = nil
        spy.complete(with: .failure(.unexpected))

        // Then
        XCTAssertEqual(delegate.messages, [.loader(isLoading: true)])
    }
}

private extension SearchImagePresenterTests {
    func makeSUT(delegate: DelegateSpy = DelegateSpy()) -> (SearchImagePresenter, LoadSearchItemsSpy) {
        let spy = LoadSearchItemsSpy()
        let sut = SearchImagePresenter(serchLoader: spy)
        sut.delegate = delegate

        trackForMemoryLeak(for: spy)
        trackForMemoryLeak(for: sut)

        return (sut, spy)
    }
}
