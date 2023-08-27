//
//  RemoteLoadSearchItemsTests.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 23/08/23.
//

import LHNetworkClient
import XCTest
@testable import AppGarden

final class RemoteLoadSearchItemsTests: XCTestCase {
    func test_search_shouldSendCorrectHTTPProvider() {
        // Given
        let (sut, spy) = makeSUT()
        let query = "test"
        
        // When
        sut.search(query: query) { _ in }
        
        // Then
        XCTAssertEqual(spy.providers.count, 1)
        XCTAssertEqual(spy.providers.first?.url.description, Enviroment.baseURL)
        XCTAssertEqual(spy.providers.first?.queryParams, ["nojsoncallback": "1", "tags": query, "format": "json"])
        XCTAssertNotNil(spy.providers.first?.jsonDecoder)
        XCTAssertNil(spy.providers.first?.headers)
        XCTAssertNil(spy.providers.first?.body)
    }
    
    func test_search_shouldCompleteWithUnexpectedErrorIfClientCompletesWithError() {
        // Given
        let (sut, spy) = makeSUT()
        var receivedResult: Result<[SearchItemResponse], DomainError>?
        
        // When
        sut.search(query: String()) { receivedResult = $0 }
        spy.complete(with: .failure(.forbidden))
        
        // Then
        XCTAssertEqual(receivedResult, .failure(.unexpected))
    }
    
    func test_search_shouldCompleteWithUnexpectedErrorWithInvalidURL() {
        // Given
        let (sut, _) = makeSUT(baseURL: String())
        var receivedResult: Result<[SearchItemResponse], DomainError>?
        
        // When
        sut.search(query: String()) { receivedResult = $0 }
        
        // Then
        XCTAssertEqual(receivedResult, .failure(.unexpected))
    }
    
    func test_search_shouldSucceedIfClientCompletesWithSuccess() {
        let (sut, spy) = makeSUT()
        let expectedData = makeFakeSearchResponse()
        
        expect(sut: sut, with: .success(expectedData.items)) {
            spy.complete(with: .success(expectedData))
        }
    }
}

private extension RemoteLoadSearchItemsTests {
    func makeSUT(baseURL: String = Enviroment.baseURL) -> (RemoteLoadSearchItems, HTTPClientSpy) {
        let clientSpy = HTTPClientSpy()
        let sut = RemoteLoadSearchItems(client: clientSpy, baseURL: baseURL)
        
        trackForMemoryLeak(for: clientSpy)
        trackForMemoryLeak(for: sut)
        
        return (sut, clientSpy)
    }
    
    func expect(sut: RemoteLoadSearchItems,
                with result: Result<[SearchItemResponse], DomainError>,
                when action: () -> Void, file: StaticString = #filePath,
                line: UInt = #line) {
        // Given
        var receivedResult: Result<[SearchItemResponse], DomainError>?
        
        // When
        sut.search(query: String()) { receivedResult = $0 }
        action()
        
        // Then
        XCTAssertEqual(receivedResult, result, file: file, line: line)
    }
}
