//
//  ImageLoaderComposite.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 31/08/23.
//

import Foundation

final class ImageLoaderComposite: ImageLoader {
    let primary: ImageLoader
    let fallback: ImageLoader

    init(primary: ImageLoader, fallback: ImageLoader) {
        self.primary = primary
        self.fallback = fallback
    }
    
    func load(url: URL?, completion: @escaping (Data?) -> Void) {
        primary.load(url: url, completion: { [weak self] data in
            guard let data = data else {
                print("App: Will fetch remote image")
                self?.fallback.load(url: url, completion: completion)
                return
            }
            print("APP: Image alredy cached")
            completion(data)
        })
    }
}
