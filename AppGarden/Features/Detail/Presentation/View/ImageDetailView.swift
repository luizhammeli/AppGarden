//
//  ImageDetailView.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 24/08/23.
//

import LHDSComponents
import LHHelpers
import UIKit

final class ImageDetailView: UIView {
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    private let stackView = UIStackView()
    private let imageStackView = UIStackView()
    private let imageView = CustomImageView()
    private let containerInfoView = DetailInfoContainerView()
    private var tagView = TagView()
        
    private let spacing = Spacing.xxLarge
    private var viewModel: ImageDetailViewModel?
    private lazy var tagViewWidth = UIScreen.main.bounds.width - (spacing * 2)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupImage(viewModel: ImageDetailViewModel?) {
        guard let viewModel = viewModel else { return }
        
        self.viewModel = viewModel

        imageView.image(viewModel.image)
        imageView.anchor(size: viewModel.size)

        imageStackView.addArrangedSubview(UIView())
        imageStackView.addArrangedSubview(imageView)
        imageStackView.addArrangedSubview(UIView())

        stackView.addArrangedSubview(imageStackView)

        containerInfoView.set(items: viewModel.items)
        stackView.addArrangedSubview(containerInfoView)
        
        tagView.set(tags: viewModel.tags, width: tagViewWidth)
        stackView.addArrangedSubview(tagView)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updatesTagViewForNewOrientation()
    }
    
    private func updatesTagViewForNewOrientation() {
        stackView.removeArrangedSubview(tagView)
        tagView.removeFromSuperview()
        tagView = TagView(tags: viewModel?.tags ?? [], width: UIScreen.main.bounds.width - (spacing * 2))
        stackView.addArrangedSubview(tagView)
    }
}

extension ImageDetailView: CodeView {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(stackView)
    }
    
    func setupConstraints() {
        scrollView.fillSuperview()
        containerView.fillSuperview()
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1).isActive = true
        stackView.fillSuperview(padding: UIEdgeInsets(top: .zero, left: spacing, bottom: .zero, right: spacing))
    }
    
    func setupAdditionalConfiguration() {
        stackView.axis = .vertical
        stackView.spacing = Spacing.extraLarge
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: Spacing.extraLarge, left: .zero, bottom: .zero, right: .zero)
        
        imageStackView.distribution = .equalCentering
    }
}
