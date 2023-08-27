//
//  ImageDetailView.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 24/08/23.
//

import LHHelpers
import UIKit

final class ImageDetailView: UIView {
    private let imageView = CustomImageView()
    private let containerInfoView = DetailInfoContainerView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImage(viewModel: ImageDetailViewModel) {
        addSubview(imageView)
        addSubview(containerInfoView)
                
        imageView.image(viewModel.image)
        imageView.anchor(size: viewModel.size)
        imageView.anchor(top: safeAreaLayoutGuide.topAnchor, padding: UIEdgeInsets(top: Spacing.extraLarge, left: .zero, bottom: .zero, right: .zero))
        imageView.centerXInSuperview()
        
        containerInfoView.set(items: viewModel.items)
        
        containerInfoView.anchor(top: imageView.bottomAnchor,
                                 leading: leadingAnchor,
                                 trailing: trailingAnchor,
                                 padding: UIEdgeInsets(top: Spacing.extraLarge, left: Spacing.xxLarge, bottom: .zero, right: Spacing.xxLarge))
    }
}
