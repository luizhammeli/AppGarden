//
//  LocalImageLoader.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 31/08/23.
//

import Foundation

final class LocalImageLoader: ImageLoader {
    let client: CacheClient

    init(client: CacheClient) {
        self.client = client
    }
    
    func load(strURL: String, completion: @escaping (Data?) -> Void) {
        let cachedData = client.fetch(with: strURL)
        completion(cachedData?.value)
    }
}

protocol CacheImage {
    func save(strURL: String, data: Data)
}

final class LocalCacheImage: CacheImage {
    let client: CacheClient

    init(client: CacheClient) {
        self.client = client
    }
    
    func save(strURL: String, data: Data) {
        client.save(key: strURL, data: data)
    }
}
