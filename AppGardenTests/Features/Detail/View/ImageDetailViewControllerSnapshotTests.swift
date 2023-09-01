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