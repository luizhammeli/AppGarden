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
    
    func makeSearchGridView(client: HTTPClient = URLSessionHttpClient()) -> SearchGridMainView {        
        let useCase = RemoteLoadSearchItems(client: client)
        let decorator = MainQueueDispatchDecorator(instance: useCase)
        let presenter = SearchImagePresenter(serchLoader: decorator)
        let layoutDataSource = SearchImageLayoutDataSource()
        let controller = SearchGridController(presenter: presenter)
        let view = SearchGridMainView(controller: controller, layoutMapper: layoutDataSource)
        presenter.delegate = controller
        return view
    }
}
