//
//  RemoteImageLoader.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 31/08/23.
//

import Foundation
import LHNetworkClient

protocol ImageLoader {
    func load(url: URL?, completion: @escaping (Data?) -> Void)
}

final class RemoteImageLoader: ImageLoader {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func load(url: URL?, completion: @escaping (Data?) -> Void) {
        guard let url = url else { return completion(nil) }
        let provider = ImageLoaderProvider(url: url)
        client.fetch(provider: provider) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure:
                completion(nil)
            }
        }
    }
}
