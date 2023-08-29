//
//  ImageDetailViewControllerSnapshotTests.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 29/08/23.
//

import SnapshotTesting
import XCTest
@testable import AppGarden

final class ImageDetailViewControllerSnapshotTests: XCTestCase {
    func test_snapshot_shouldErrorView() {
        let (_, navController) = makeSUT()

        assertSnapshot(matching: navController, as: .image(on: .iPhoneX(.portrait)))
    }
    
//    func test_snapshot_shouldShowLoader() {
//        let sut = makeSUT()
//
//        sut.showLoader(isLoading: true)
//
//        assertSnapshot(matching: navController, as: .image(on: .iPhoneX(.portrait)))
//    }
//
//    func test_snapshot_shouldNotShowLoader() {
//        let sut = makeSUT()
//
//        sut.showLoader(isLoading: false)
//
//        assertSnapshot(matching: navController, as: .image(on: .iPhoneX(.portrait)))
//    }
//
//    func test_snapshot_shouldShowGridView() {
//        let sut = makeSUT()
//        let items = [makeFakeSearchImageViewModel(with: makeFakeSearchItemResponse())]
//
//        sut.view(items: items)
//        sut.setFakeImage(at: 0)
//
//        assertSnapshot(matching: navController, as: .image(on: .iPhoneX(.portrait)))
//    }
}

private extension ImageDetailViewControllerSnapshotTests {
    func makeSUT() -> (ImageDetailViewController, UINavigationController) {
        let stub = ImageDetailPresenterStub(viewModel: makeDetailViewModel())
        let sut = ImageDetailViewController(presenter: stub)
        
        let navController = UINavigationController(rootViewController: sut)
        
        sut.loadViewIfNeeded()

        return (sut, navController)
    }
}
