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
    func test_snapshot_shouldShowDetailView() {
        let (_, navController) = makeSUT()
        assertSnapshot(matching: navController, as: .image(on: .iPhone13Pro(.portrait)))
    }
    
    func test_snapshot_shouldShowDetailViewInLandscapeMode() {
        let (_, navController) = makeSUT()
        assertSnapshot(matching: navController, as: .image(on: .iPhone13Pro(.landscape)))
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
