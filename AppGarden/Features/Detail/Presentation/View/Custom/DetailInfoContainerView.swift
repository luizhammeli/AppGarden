//
//  DetailInfoContainerView.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 24/08/23.
//

import LHHelpers
import UIKit

final class DetailInfoContainerView: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Spacing.small
        return stackView
    }()

    init() {
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(items: [ImageItemViewModel]) {
        items.forEach {
            stackView.addArrangedSubview(DetailRowView(viewModel: $0))
        }
    }
}

extension DetailInfoContainerView: CodeView {
    func buildViewHierarchy() {
        addSubviews(stackView)
    }

    func setupConstraints() {
        stackView.fillSuperview()
    }

    func setupAdditionalConfiguration() {
        layer.cornerRadius = BorderRadius.small
        backgroundColor = .secondarySystemBackground
    }
}
