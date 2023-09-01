//
//  ImageGridView.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 23/08/23.
//

import LHHelpers
import UIKit

final class SearchImageView: UIView {
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()

    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()

    let activityIndicator = UIActivityIndicatorView(style: .large)

    let searchErrorView = SearchErrorView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchImageView: CodeView {
    func buildViewHierarchy() {
        addSubviews(collectionView)
        addSubview(activityIndicator)
        addSubview(searchErrorView)
    }

    func setupConstraints() {
        collectionView.fillSuperview()
        activityIndicator.centerInSuperview()
        searchErrorView.centerInSuperview()
    }

    func setupAdditionalConfiguration() {
        searchErrorView.isHidden = false
    }
}
