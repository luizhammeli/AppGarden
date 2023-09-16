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

        assertSnapshot(matching: navController, as: .image(on: .iPhone13Pro(.portrait)))
    }
    
    func test_snapshot_shouldShowLoader() {
        let (sut, navController) = makeSUT()

        sut.showLoader(isLoading: true)

        assertSnapshot(matching: navController, as: .image(on: .iPhone13Pro(.portrait)))
    }
    
    func test_snapshot_shouldNotShowLoader() {
        let (sut, navController) = makeSUT()

        sut.showLoader(isLoading: false)

        assertSnapshot(matching: navController, as: .image(on: .iPhone13Pro(.portrait)))
    }
    
    func test_snapshot_shouldShowGridView() {
        let (sut, navController) = makeSUT()
        let items = [makeFakeSearchImageViewModel(with: makeFakeSearchItemResponse())]

        sut.view(items: items)
        sut.setFakeImage(at: 0)        

        assertSnapshot(matching: navController, as: .image(on: .iPhone13Pro(.portrait)))
    }
}

private extension SearchImageViewControllerSnapshotTests {
    func makeSUT() -> (SearchImageViewController, UINavigationController) {
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
