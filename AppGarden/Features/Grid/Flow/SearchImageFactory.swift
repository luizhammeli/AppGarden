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
    static var imageLoader: ImageLoader = makeImageLoader()
    
    func makeSearchImageViewController(coordinator: SearchImageCoordinator) -> SearchImageViewController {
        let client = URLSessionHttpClient()
        let useCase = RemoteLoadSearchItems(client: client)
        let decorator = MainQueueDispatchDecorator(instance: useCase)
        let presenter = SearchImagePresenter(serchLoader: decorator, cellFactory: makeCellController)        
        let layoutDataSource = SearchImageLayoutDataSource()
        let controller = SearchImageViewController(presenter: presenter, coordinator: coordinator, layoutDataSource: layoutDataSource)
        presenter.delegate = controller
        return controller
    }
    
    static func makeImageLoader(client: HTTPClient = URLSessionHttpClient(),
                         cacheClient: CacheClient = NSCacheClient()) -> ImageLoader {
        let remoteImageLoader = RemoteImageLoader(client: client)
        let decorator = MainQueueDispatchDecorator(instance: remoteImageLoader)
        let localImageLoader = LocalImageLoader(client: cacheClient)
        let cacheImage = LocalCacheImage(client: cacheClient)
        let imageLoaderWithCache = RemoteLoadImageWithCache(imageLoader: decorator,
                                                            cacheImage: cacheImage)
        return ImageLoaderComposite(primary: localImageLoader, fallback: imageLoaderWithCache)
    }
    
    func makeCellController(items: [SearchImageViewModel]) -> [ImageGridCellController] {
        return items.map { ImageGridCellController(imageLoader: DependencyContainer.imageLoader, item: $0) }
    }
}
