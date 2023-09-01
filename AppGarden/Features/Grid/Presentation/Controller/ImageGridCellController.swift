//
//  ImageGridCellController.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 31/08/23.
//

import UIKit

final class ImageGridCellController {
    private let imageLoader: ImageLoader
    let item: SearchImageViewModel

    init(imageLoader: ImageLoader, item: SearchImageViewModel) {
        self.imageLoader = imageLoader
        self.item = item
    }
    
    func cellForItem(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as ImageGridCell
        imageLoader.load(url: item.imageURL) { [weak self] data in
            guard let self = self, let data = data else { return }
            cell.set(data: data, accessibilityTitle: item.accessibilityTitle)
        }
        return cell
    }
}
