//
//  ImageDetailViewControllerTests.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 27/08/23.
//

import XCTest
import LHDSComponents
@testable import AppGarden

final class ImageDetailViewControllerTests: XCTestCase {
    func test_setupImage_shouldRenderImageView() {
        let (sut, stub) = makeSUT()

        sut.customView.layoutIfNeeded()

        XCTAssertEqual(sut.imageView?.image, stub.viewModel?.image)
        XCTAssertEqual(sut.imageView?.frame.size, stub.viewModel?.size)
    }
    
    func test_setupData_shouldSetDetailInfoView() {
        let (sut, stub) = makeSUT()
        let item = stub.viewModel?.items.first

        XCTAssertEqual(sut.detailRowViewData.title, item?.title)
        XCTAssertEqual(sut.detailRowViewData.value, item?.value)
    }
    
    func test_setupData_shouldShowTagView() {
        let (sut, _) = makeSUT()

        XCTAssertNotNil(sut.tagView)
    }
}

private extension ImageDetailViewControllerTests {
    func makeSUT() -> (ImageDetailViewController, ImageDetailPresenterStub) {
        let stub = ImageDetailPresenterStub(viewModel: makeDetailViewModel())
        let sut = ImageDetailViewController(presenter: stub)
        
        sut.loadViewIfNeeded()
        
        trackForMemoryLeak(for: sut)
        trackForMemoryLeak(for: stub)
        
        return (sut, stub)
    }
}

extension ImageDetailViewController {
    var imageView: UIImageView? {
        let customImageView = (mainStackView?.arrangedSubviews.first as? UIStackView)?.arrangedSubviews[1] as? CustomImageView
        return (customImageView?.subviews.first as? UIImageView)
    }
    
    var detailRowView: DetailRowView? {
        (((mainStackView?.arrangedSubviews[1] as? DetailInfoContainerView)?
            .subviews.last as? UIStackView)?
            .arrangedSubviews.first as? DetailRowView)
    }
    
    var tagView: TagView? {
        mainStackView?.arrangedSubviews.last as? TagView
    }
    
    private var mainStackView: UIStackView? {
        (((customView.subviews.last as? UIScrollView)?
            .subviews.last as? UIView)?
            .subviews.last as? UIStackView)
    }
    
    var detailRowViewData: (title: String?, value: String?) {
        let title = ((detailRowView?.subviews.first as? UIStackView)?.arrangedSubviews.first as? UILabel)?.text
        let value = ((detailRowView?.subviews.first as? UIStackView)?.arrangedSubviews.last as? UILabel)?.text
        
        return (title, value)
    }
}
