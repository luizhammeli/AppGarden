//
//  SearchImageFactory.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 24/08/23.
//

import Foundation
import LHNetworkClient

protocol SearchImageFactory {
    func makeSearchImageViewController(coordinator: SearchImageCoordinator) -> SearchImageViewController
}

extension DependencyContainer: SearchImageFactory {
    func makeSearchImageViewController(coordinator: SearchImageCoordinator) -> SearchImageViewController {
        let client = URLSessionHttpClient()
        let useCase = RemoteLoadSearchItems(client: client)
        let decorator = MainQueueDispatchDecorator(instance: useCase)
        let presenter = SearchImagePresenter(serchLoader: decorator)
        let layoutDataSource = SearchImageLayoutDataSource()
        let controller = SearchImageViewController(presenter: presenter, coordinator: coordinator, layoutDataSource: layoutDataSource)
        presenter.delegate = controller
        return controller
    }
}
