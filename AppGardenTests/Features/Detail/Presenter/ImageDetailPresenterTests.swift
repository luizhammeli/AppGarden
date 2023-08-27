//
//  ImageDetailPresenterTests.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 27/08/23.
//

import XCTest
@testable import AppGarden

final class ImageDetailPresenterTests: XCTestCase {
    func test_mapData_shouldReturnCorrectTitleItems() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.viewModel?.items.count, 4)
        XCTAssertEqual(sut.viewModel?.items[0].title, "Title")
        XCTAssertEqual(sut.viewModel?.items[1].title, "Date")
        XCTAssertEqual(sut.viewModel?.items[2].title, "Height")
        XCTAssertEqual(sut.viewModel?.items[3].title, "Width")
    }
    
    func test_mapData_shouldReturnCorrectItemValue() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.viewModel?.items.count, 4)
        XCTAssertEqual(sut.viewModel?.items[0].value, "title")
        XCTAssertEqual(sut.viewModel?.items[1].value, "08/27/2023")
        XCTAssertEqual(sut.viewModel?.items[2].value, "240")
        XCTAssertEqual(sut.viewModel?.items[3].value, "160")
    }
    
    func test_mapData_shouldReturnCorrecSize() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.viewModel?.size, CGSize(width: 160, height: 240))
    }
}

private extension ImageDetailPresenterTests {
    func makeSUT() -> ImageDetailPresenter {
        let fakeViewModel = makeFakeSearchImageViewModel(with: makeFakeSearchItemResponse())
        let sut = ImageDetailPresenter(image: UIImage(), viewModel: fakeViewModel)
        
        trackForMemoryLeak(for: sut)        
        
        return sut
    }
}
