//
//  SearchImageViewTests.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 26/08/23.
//

import XCTest

@testable import AppGarden

final class SearchImageViewTests: XCTestCase {
    func test_buildViewHierarchy_shouldReturnCorrectNumberOfSubviews() {
        let sut = makeSUT()
                
        XCTAssertEqual(sut.subviews.count, 3)
    }
    
    func test_buildViewHierarchy_collectionViewShouldBeAddedCorrectly() {
        let sut = makeSUT()
                
        XCTAssertEqual(sut.subviews.first, sut.collectionView)
    }
    
    func test_buildViewHierarchy_activityIndicatorShouldBeAddedCorrectly() {
        let sut = makeSUT()
                
        XCTAssertEqual(sut.subviews[1], sut.activityIndicator)
    }
    
    func test_buildViewHierarchy_errorViewShouldBeAddedCorrectly() {
        let sut = makeSUT()
                
        XCTAssertEqual(sut.subviews.last, sut.searchErrorView)
    }
}

private extension SearchImageViewTests {
    func makeSUT() -> SearchImageView {
        let sut = SearchImageView(frame: .zero)
        trackForMemoryLeak(for: sut)
        
        return sut
    }
}
