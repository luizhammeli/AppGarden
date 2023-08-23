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
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        customView.collectionView.dataSource = self
        customView.collectionView.delegate = self
        customView.collectionView.register(ImageGridCell.self)
    }
}

extension ImageGridViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as ImageGridCell
        cell.backgroundColor = .red
        return cell
    }
}

extension ImageGridViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
}

final class ImageGridView: UIView {
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .systemBackground
        return collectionView
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
    
}
