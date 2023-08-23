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

final class SearchErrorView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "No Results"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Try a new search."
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    init(title: String = L10n.searchErrorTitle, description: String = L10n.searchErrorDescription) {
        super.init(frame: .zero)
        titleLabel.text = title
        subtitleLabel.text = description
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchErrorView: CodeView {
    func buildViewHierarchy() {
        addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.fillSuperview()
    }
    
    func setupAdditionalConfiguration() {}
}
