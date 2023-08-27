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
    
    func test_didSelect_shouldCallCoordinator() {
        let coordinator = SearchImageCoordinatorSpy()
        let viewModel = makeFakeSearchImageViewModel(with: makeFakeSearchItemResponse())
        let (sut, _) = makeSUT(coodinatorSpy: coordinator)

        sut.view(items: [viewModel])
        sut.didSelect(index: 0)
        
        
        XCTAssertEqual(coordinator.receivedData.count, 1)
        XCTAssertEqual(coordinator.receivedData[0].viewModel, viewModel)
    }
    
    func test_minimumLineSpacing_shouldReturnCorrectValue() {
        let layout = SearchImageLayoutDataSource()
        let (sut, _) = makeSUT()

        XCTAssertEqual(sut.minimumLineSpacing(), layout.lineSpacing)
    }
    
    func test_minimumItemSpacing_shouldReturnCorrectValue() {
        let layout = SearchImageLayoutDataSource()
        let (sut, _) = makeSUT()

        XCTAssertEqual(sut.minimumInteritemSpacing(), layout.itemSpacing)
    }
    
    func test_sizeForItem_shouldReturnCorrectValue() {
        let layout = SearchImageLayoutDataSource()
        let (sut, _) = makeSUT()

        XCTAssertEqual(sut.sizeForItem(), layout.cellSize(width: .zero, verticalSize: .regular))
    }
}

private extension SearchImageViewControllerTests {
    func makeSUT(coodinatorSpy: SearchImageCoordinatorProtocol = SearchImageCoordinatorSpy()) -> (SearchImageViewController, SearchImagePresenterSpy){
        let presenterSpy = SearchImagePresenterSpy()
        let sut = SearchImageViewController(presenter: presenterSpy, coordinator: coodinatorSpy, layoutDataSource: SearchImageLayoutDataSource())
        _ = UINavigationController(rootViewController: sut)
        
        sut.loadViewIfNeeded()
        
        trackForMemoryLeak(for: sut)
        trackForMemoryLeak(for: presenterSpy)
        
        return (sut, presenterSpy)
    }
}

private extension SearchImageViewController {
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
    
    func didSelect(index: Int) {
        collectionView(customView.collectionView, didSelectItemAt: IndexPath(item: index, section: index))
    }
    
    func makeSearch(value: String) {
        searchBar(customView.searchController.searchBar, textDidChange: value)
    }
    
    func minimumLineSpacing() -> CGFloat {
        collectionView(customView.collectionView, layout: UICollectionViewFlowLayout(), minimumLineSpacingForSectionAt: 0)
    }
    
    func minimumInteritemSpacing() -> CGFloat {
        collectionView(customView.collectionView, layout: UICollectionViewFlowLayout(), minimumInteritemSpacingForSectionAt: 0)
    }
    
    func sizeForItem() -> CGSize {
        collectionView(customView.collectionView, layout: UICollectionViewFlowLayout(), sizeForItemAt: IndexPath(item: 0, section: 0))
    }
}
