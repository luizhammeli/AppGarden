//
//  ImageDetailViewController.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 24/08/23.
//

import LHHelpers
import UIKit

final class ImageDetailViewController: CustomViewController<ImageDetailView> {
    let presenter: ImageDetailPresenterProtocol

    init(presenter: ImageDetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        customView.setupImage(viewModel: presenter.viewModel)
    }

    private func setupNavigationBar() {
        navigationItem.title = L10n.detailsScreenTitle
        navigationItem.largeTitleDisplayMode = .never
    }
}
