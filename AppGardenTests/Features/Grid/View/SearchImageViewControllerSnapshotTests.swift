//
//  SearchImageViewControllerSnapshotTests.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 27/08/23.
//

import SnapshotTesting
import XCTest
@testable import AppGarden

final class SearchImageViewControllerSnapshotTests: XCTestCase {
    func test_snapshot_shouldErrorView() {
        let (sut, navController) = makeSUT()

        sut.showError()

        assertSnapshot(of: navController, as: .image(on: .iPhone13(.portrait), perceptualPrecision: 0.99))
    }
    
    func test_snapshot_shouldShowLoader() {
        let (sut, navController) = makeSUT()

        sut.showLoader(isLoading: true)

        assertSnapshot(of: navController, as: .image(on: .iPhone13(.portrait), perceptualPrecision: 0.99))
    }
    
    func test_snapshot_shouldNotShowLoader() {
        let (sut, navController) = makeSUT()

        sut.showLoader(isLoading: false)

        assertSnapshot(of: navController, as: .image(on: .iPhone13(.portrait), perceptualPrecision: 0.99))
    }
    
    func test_snapshot_shouldShowGridView() {
        let (sut, navController) = makeSUT()
        let items = [makeFakeSearchImageViewModel(with: makeFakeSearchItemResponse())]

        sut.view(items: items)
        sut.setFakeImage(at: 0)        

        assertSnapshot(of: navController, as: .image(on: .iPhone13(.portrait), perceptualPrecision: 0.99))
    }
}

private extension SearchImageViewControllerSnapshotTests {
    func makeSUT() -> (SearchImageViewController, UINavigationController) {
        SnapshotTesting.diffTool = "ksdiff"
        let dummyCoordinator = SearchImageCoordinatorSpy()
        let dummyPresenter = SearchImagePresenterSpy()
        let sut = SearchImageViewController(presenter: dummyPresenter,
                                            coordinator: dummyCoordinator,
                                            layoutDataSource: SearchImageLayoutDataSource())
        let navController = UINavigationController(rootViewController: sut)

        navController.loadViewIfNeeded()

        return (sut, navController)
    }
}
