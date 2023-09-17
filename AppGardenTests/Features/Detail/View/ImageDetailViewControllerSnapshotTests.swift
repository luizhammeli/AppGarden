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
        let (_, navController) = makeSUT(tags: ["FirstTest", "SecondTest"])
        assertSnapshot(matching: navController, as: .image(size: CGSize(width: 375, height: 667)))
    }
    
    func test_snapshot_shouldShowDetailViewWithOneTag() {
        let (_, navController) = makeSUT(tags: ["FirstTest"])
        assertSnapshot(matching: navController, as: .image(on: .iPhone8(.portrait)))
    }
    
    func test_snapshot_shouldShowDetailViewWithoutTags() {
        let (_, navController) = makeSUT(tags: [])
        assertSnapshot(matching: navController, as: .image(on: .iPhone8(.portrait)))
    }
    
    func test_snapshot_shouldShowDetailViewWithManyLines() {
        let tags = ["FirstTest", "SecondTest", "ThirdTest", "FourthTest", "FifthTest", "SixthTest", "SeventhTag"]
        let (_, navController) = makeSUT(tags: tags)
        assertSnapshot(matching: navController, as: .image(on: .iPhone8(.portrait)))
    }
    
    func test_snapshot_shouldShowDetailViewInLandscapeMode() {
        let (_, navController) = makeSUT(tags: ["FirstTest", "SecondTest"])
        assertSnapshot(matching: navController, as: .image(on: .iPhone8(.landscape)))
    }
}

private extension ImageDetailViewControllerSnapshotTests {
    func makeSUT(tags: [String]) -> (ImageDetailViewController, UINavigationController) {
        SnapshotTesting.diffTool = "ksdiff"
        
        let stub = ImageDetailPresenterStub(viewModel: makeDetailViewModel(tags: tags))
        let sut = ImageDetailViewController(presenter: stub)
        
        let navController = UINavigationController(rootViewController: sut)
        
        sut.loadViewIfNeeded()

        return (sut, navController)
    }
}
