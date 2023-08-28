//
//  SearchImageViewController+Tests.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 27/08/23.
//

import UIKit
@testable import AppGarden

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
    
    func setFakeImage(at index: Int) {
        _ = cell(index: index)
        customView.layoutIfNeeded()
        let cell = customView.collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? ImageGridCell
        (cell?.subviews.first as? UIImageView)?.backgroundColor = .red
    }
}
