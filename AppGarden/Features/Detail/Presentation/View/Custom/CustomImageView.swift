//
//  CustomImageView.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 27/08/23.
//

import LHHelpers
import UIKit

final class CustomImageView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = BorderRadius.medium
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func image(_ image: UIImage) {
        imageView.image = image
    }
}

extension CustomImageView: CodeView {
    func buildViewHierarchy() {
        addSubview(imageView)
    }

    func setupConstraints() {
        imageView.fillSuperview()
    }

    func setupAdditionalConfiguration() {
        applyShadow(color: .label)
    }
}
