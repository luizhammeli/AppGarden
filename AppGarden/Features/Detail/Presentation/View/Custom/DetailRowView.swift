//
//  DetailRowView.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 24/08/23.
//

import LHHelpers
import UIKit

final class DetailRowView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: FontSizeConstants.small)
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: FontSizeConstants.small)
        label.minimumScaleFactor = 0.8
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var stackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stackView.spacing = Spacing.small
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: Spacing.medium, left: Spacing.large, bottom: Spacing.medium, right: Spacing.large)
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    init(title: String, value: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        valueLabel.text = value
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailRowView: CodeView {
    func buildViewHierarchy() {
        addSubview(stackView)
        addSubview(separatorView)
    }
    
    func setupConstraints() {
        stackView.fillSuperview()
        separatorView.anchor(leading: leadingAnchor,
                             bottom: stackView.bottomAnchor,
                             trailing: trailingAnchor,
                             padding: UIEdgeInsets(top: .zero, left: Spacing.medium, bottom: .zero, right: Spacing.medium))
        separatorView.anchor(size: CGSize(width: .zero, height: 1))
    }
    
    func setupAdditionalConfiguration() {}
}
