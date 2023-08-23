//
//  ImageGridCell.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 23/08/23.
//

import LHHelpers
import SDWebImage
import UIKit

final class ImageGridCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.sd_imageTransition = .fade
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(url: URL?) {        
        imageView.sd_setImage(with: url)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
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
