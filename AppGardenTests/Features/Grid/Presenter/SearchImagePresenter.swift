//
//  SearchImagePresenter.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 25/08/23.
//

import XCTest
@testable import AppGarden

final class SearchImagePresenterTests: XCTestCase {
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
        let (sut, spy) = makeSUT(delegate: delegate)
        
        // When
        sut.makeSearch(query: "test")
        spy.complete(with: .success([]))
        
        // Then
        //XCTAssertEqual(delegate.messages, [.loader(isLoading: true), .loader(isLoading: false), .error])
    }
}

private extension SearchImagePresenterTests {
    func makeSUT(delegate: DelegateSpy) -> (SearchImagePresenter, LoadSearchItemsSpy) {
        let spy = LoadSearchItemsSpy()
        let sut = SearchImagePresenter(serchLoader: spy)
        sut.delegate = delegate
        
        trackForMemoryLeak(for: spy)
        trackForMemoryLeak(for: sut)
        
        return (sut, spy)
    }
}

final class LoadSearchItemsSpy: LoadSearchItems {
    var completions: [(LoadSearchItems.Result) -> Void] = []

    func search(query: String, completion: @escaping (LoadSearchItems.Result) -> Void) {
        completions.append(completion)
    }
    
    func complete(with result: Result<[AppGarden.SearchItemResponse], AppGarden.DomainError>, at index: Int = 0) {
        completions[index](result)
    }
}

enum DelegateMessage: Equatable {
    case view(items: [AppGarden.SearchImageViewModel])
    case loader(isLoading: Bool)
    case error
}

final class DelegateSpy: SearchPresenterDelegateProtocol {
    var messages: [DelegateMessage] = []
    
    func view(items: [AppGarden.SearchImageViewModel]) {
        messages.append(.view(items: items))
    }
    
    func showLoader(isLoading: Bool) {
        messages.append(.loader(isLoading: isLoading))
    }
    
    func showError() {
        messages.append(.error)
    }
}
