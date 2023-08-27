//
//  SearchImageCoordinatorTests.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 25/08/23.
//

import XCTest
@testable import AppGarden

final class SearchImageCoordinatorTests: XCTestCase {
    func test_start_shouldSetRootViewControoler() {
        // Given
        let window = UIWindow()
        let navigationController = UINavigationController()
        let sut = makeSUT(window: window, navigationController: navigationController)

        // When
        sut.start()

        // Then
        XCTAssertEqual(window.rootViewController, navigationController)
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertTrue(navigationController.viewControllers.first is SearchImageViewController)
    }

    func test_start_shouldNavigateToDetailController() {
        // Given
        let dummyViewModel = makeFakeSearchImageViewModel(with: makeFakeSearchItemResponse())
        let navigationController = NavigationControllerSpy()
        let sut = makeSUT(navigationController: navigationController)

        // When
        sut.goToDetail(image: UIImage(), viewModel: dummyViewModel)

        // Then
        XCTAssertEqual(navigationController.controllers.count, 1)
        XCTAssertTrue(navigationController.controllers.first is ImageDetailViewController)
    }
}

private extension SearchImageCoordinatorTests {
    func makeSUT(window: UIWindow = UIWindow(), navigationController: UINavigationController) -> SearchImageCoordinator {
        return SearchImageCoordinator(navigationController: navigationController, factory: DependencyContainer(), window: window)
    }
}
