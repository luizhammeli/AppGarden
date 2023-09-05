//
//  SearchImageCoordinator.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 24/08/23.
//

import UIKit
import LHNetworkClient

protocol SearchImageCoordinatorProtocol: AnyObject {
    func goToDetail(image: UIImage?, viewModel: SearchImageViewModel?)
}

final class SearchImageCoordinator: Coordinator {
    typealias Factory = SearchImageFactory & ImageDetailFactory
    private var navigationController: UINavigationController
    private let factory: Factory
    private let window: UIWindow?

    init(navigationController: UINavigationController = UINavigationController(), factory: Factory, window: UIWindow?) {
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
    func goToDetail(image: UIImage?, viewModel: SearchImageViewModel?) {
        guard let image = image, let viewModel = viewModel else { return }
        let controller = factory.makeSearchImageViewController(image: image, viewModel: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
}
