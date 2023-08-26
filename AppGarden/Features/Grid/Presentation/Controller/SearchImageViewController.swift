//
//  ViewController.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 23/08/23.
//

import LHHelpers
import UIKit

final class SearchImageViewController: CustomViewController<SearchImageView> {
    private let coordinator: SearchImageCoordinatorProtocol
    private let presenter: SearchImagePresenterProtocol
    private let layoutDataSource: GridViewFlowLayoutDataSourceProtocol
    
    private var searchItems: [SearchImageViewModel] = [] {
        didSet {
            customView.collectionView.reloadData()
        }
    }
    
    init(presenter: SearchImagePresenterProtocol,
         coordinator: SearchImageCoordinatorProtocol,
         layoutDataSource: GridViewFlowLayoutDataSourceProtocol) {
        self.presenter = presenter
        self.coordinator = coordinator
        self.layoutDataSource = layoutDataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        setupCollectionView()
        setupNavigationBar()
        setupResultController()
    }
    
    private func setupCollectionView() {
        customView.collectionView.dataSource = self
        customView.collectionView.delegate = self
        customView.collectionView.register(ImageGridCell.self)
    }
    
    private func setupResultController() {
        customView.searchController.searchBar.delegate = self
        navigationItem.searchController = customView.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupNavigationBar() {
        navigationItem.title = L10n.gridViewTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        customView.collectionView.reloadData()
    }
}

// MARK: UISearchBarDelegate

extension SearchImageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.makeSearch(query: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        showError()
    }
}

// MARK: UISearchBarDelegate

extension SearchImageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as ImageGridCell
        cell.set(url: searchItems[indexPath.item].imageURL)
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension SearchImageViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageGridCell, let image = cell.image else { return }        
        coordinator.goToDetail(image: image, viewModel: searchItems[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return layoutDataSource.cellSize(width: view.frame.width,
                                         verticalSize: traitCollection.verticalSizeClass)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return layoutDataSource.lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return layoutDataSource.itemSpacing
    }
}

// MARK: SearchPresenterDelegateProtocol

extension SearchImageViewController: SearchPresenterDelegateProtocol {
    func view(items: [SearchImageViewModel]) {
        customView.searchErrorView.isHidden = true
        self.searchItems = items
    }
    
    func showLoader(isLoading: Bool) {
        customView.searchErrorView.isHidden = true
        if isLoading {
            customView.activityIndicator.startAnimating()
        } else {            
            customView.activityIndicator.stopAnimating()
        }
    }
    
    func showError() {
        searchItems.removeAll()
        customView.searchErrorView.isHidden = false
    }
}
