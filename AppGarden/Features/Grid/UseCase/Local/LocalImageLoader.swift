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
    
    func load(url: URL?, completion: @escaping (Data?) -> Void) {
        guard let url = url else { return completion(nil) }
        let cachedData = client.fetch(with: url.description)
        completion(cachedData?.value)
    }
}
