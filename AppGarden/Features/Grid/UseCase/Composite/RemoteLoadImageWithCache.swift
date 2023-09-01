//
//  RemoteLoadImageWithCache.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 31/08/23.
//

import Foundation

final class RemoteLoadImageWithCache: ImageLoader {
    let imageLoader: ImageLoader
    let cacheImage: CacheImage

    init(imageLoader: ImageLoader, cacheImage: CacheImage) {
        self.imageLoader = imageLoader
        self.cacheImage = cacheImage
    }
    
    func load(url: URL?, completion: @escaping (Data?) -> Void) {
        imageLoader.load(url: url) { [weak self] data in
            if let data = data {
                self?.cacheImage.save(strURL: url?.description ?? "", data: data)
                completion(data)
            }
            completion(nil)
        }
    }
}
