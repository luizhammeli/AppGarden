//
//  ViewController.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 23/08/23.
//

import LHHelpers
import UIKit

final class ImageGridViewController: CustomViewController<ImageGridView> {
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
        navigationItem.title = "App Garden"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension ImageGridViewController: UISearchBarDelegate {    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

extension ImageGridViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as ImageGridCell
        cell.set(image: UIImage(named: "test"))
        return cell
    }
}

extension ImageGridViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: Add flow logic
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGFloat = (view.frame.width - 8) / 3
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}

final class ImageGridView: UIView {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageGridView: CodeView {
    func buildViewHierarchy() {
        addSubviews(collectionView)
    }
    
    func setupConstraints() {
        collectionView.fillSuperview()
    }
    
    func setupAdditionalConfiguration() {}
}

final class ImageGridCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(image: UIImage?) {
        imageView.image = image
    }
}

extension ImageGridCell: CodeView {
    func buildViewHierarchy() {
        addSubview(imageView)
    }
    
    func setupConstraints() {
        imageView.fillSuperview()
    }
    
    func setupAdditionalConfiguration() {}
}
