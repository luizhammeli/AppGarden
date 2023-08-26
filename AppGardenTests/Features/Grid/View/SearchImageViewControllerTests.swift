//
//  SearchImageViewControllerTests.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 26/08/23.
//

import XCTest
@testable import AppGarden

final class SearchImageViewControllerTests: XCTestCase {
    func test_setupResultController_checkDelegates() {
        let (sut, _) = makeSUT()
                
        XCTAssertNotNil(sut.customView.searchController.searchBar.delegate)
    }
    
    func test_setupCollectionView_checkDelegates() {
        let (sut, _) = makeSUT()
                
        XCTAssertNotNil(sut.customView.collectionView.dataSource)
        XCTAssertNotNil(sut.customView.collectionView.delegate)
    }
    
    func test_search_shouldShowErrorViewWhenSearchWasCancelled() {
        let (sut, _) = makeSUT()
        
        sut.showLoader(isLoading: true)
        sut.searchBarCancelButtonClicked(sut.customView.searchController.searchBar)
        
        XCTAssertFalse(sut.errorView.isHidden)
    }
    
    func test_showLoader_shouldHideErrorView() {
        let (sut, _) = makeSUT()
                
        sut.showLoader(isLoading: true)
        XCTAssertTrue(sut.errorView.isHidden)
        
        sut.showLoader(isLoading: false)
        XCTAssertTrue(sut.errorView.isHidden)
    }
    
    func test_showLoader_shouldShowLoader() {
        let (sut, _) = makeSUT()
                
        sut.showLoader(isLoading: true)
                
        XCTAssertTrue(sut.isLoading)
    }
    
    func test_showLoader_shouldHideLoader() {
        let (sut, _) = makeSUT()
        
        sut.showLoader(isLoading: false)
                
        XCTAssertFalse(sut.isLoading)
    }
    
    func test_showError_shouldShowErrorView() {
        let (sut, _) = makeSUT()
        
        sut.showError()

        XCTAssertFalse(sut.errorView.isHidden)
    }
    
    func test_view_shouldHideErrorView() {
        let (sut, _) = makeSUT()
        
        sut.view(items: [])

        XCTAssertTrue(sut.errorView.isHidden)
    }
    
    func test_viewDidLoad_shouldStartWithEmptyState() {
        let (sut, _) = makeSUT()
        
        XCTAssertFalse(sut.errorView.isHidden)
        XCTAssertEqual(sut.numberOfItems, 0)
    }
    
    func test_search_shouldSendCorrectQuery() {
        let query = "test"
        let (sut, spy) = makeSUT()
        
        sut.makeSearch(value: query)
        
        XCTAssertEqual(spy.queries, [query])
    }
    
    func test_search_shouldShowCorrectNumberOfItemsInTheGrid() {
        let (sut, _) = makeSUT()
        let items = [makeFakeSearchImageViewModel(with: makeFakeSearchItemResponse()),
                     makeFakeSearchImageViewModel(with: makeFakeSearchItemResponse())]
                
        sut.view(items: items)
        
        XCTAssertEqual(sut.numberOfItems, 2)
    }
    
    func test_search_shouldDequeueCell() {
        let (sut, _) = makeSUT()
                
        sut.view(items: [makeFakeSearchImageViewModel(with: makeFakeSearchItemResponse())])
        
        XCTAssertNotNil(sut.cell(index: 0))
    }
}

private extension SearchImageViewControllerTests {
    func makeSUT(coodinatorSpy: SearchImageCoordinatorProtocol = SearchImageCoordinatorSpy()) -> (SearchImageViewController, SearchImagePresenterSpy){
        let presenterSpy = SearchImagePresenterSpy()
        let sut = SearchImageViewController(presenter: presenterSpy, coordinator: coodinatorSpy)
        _ = UINavigationController(rootViewController: sut)
        
        sut.loadViewIfNeeded()
        
        return (sut, presenterSpy)
    }
}

final class SearchImagePresenterSpy: SearchImagePresenterProtocol {
    var queries: [String] = []
    
    func makeSearch(query: String) {
        queries.append(query)
    }
}

final class SearchImageCoordinatorSpy: SearchImageCoordinatorProtocol {
    var receivedData: [(image: UIImage, viewModel: AppGarden.SearchImageViewModel)] = []

    func goToDetail(image: UIImage, viewModel: AppGarden.SearchImageViewModel) {
        receivedData.append((image: image, viewModel: viewModel))
    }
}

extension SearchImageViewController {
    
    var isLoading: Bool {
        return customView.activityIndicator.isAnimating
    }
    
    var errorView: UIView {
        return customView.searchErrorView
    }
    
    var numberOfItems: Int {
        customView.collectionView.numberOfItems(inSection: 0)
    }

    
    func cell(index: Int) -> ImageGridCell {
        collectionView(customView.collectionView, cellForItemAt: IndexPath(item: index, section: index)) as! ImageGridCell
    }
    
    func makeSearch(value: String) {
        searchBar(customView.searchController.searchBar, textDidChange: value)
    }
}
