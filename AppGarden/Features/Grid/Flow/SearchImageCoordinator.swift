//
//  SearchImageCoordinator.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 24/08/23.
//

import UIKit
import LHNetworkClient

protocol SearchImageCoordinatorProtocol: AnyObject {
    func goToDetail(image: UIImage, viewModel: SearchImageViewModel)
}

final class SearchImageCoordinator: Coordinator {
    private var navigationController: UINavigationController
    private let factory: SearchImageFactory
    private let window: UIWindow?

    init(navigationController: UINavigationController = UINavigationController(), factory: SearchImageFactory, window: UIWindow?) {
        self.navigationController = navigationController
        self.factory = factory
        self.window = window
    }

    func start() {
        let controller = factory.makeSearchImageViewController(coordinator: self)
        navigationController.viewControllers = [controller]
        window?.rootViewController = navigationController
    }
}

extension SearchImageCoordinator: SearchImageCoordinatorProtocol {
    func goToDetail(image: UIImage, viewModel: SearchImageViewModel) {
        let presenter = ImageDetailPresenter(image: image, viewModel: viewModel)
        navigationController.pushViewController(ImageDetailViewController(presenter: presenter), animated: true)
    }
}
