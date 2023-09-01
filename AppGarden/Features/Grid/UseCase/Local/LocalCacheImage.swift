//
//  LocalCacheImage.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 31/08/23.
//

import Foundation

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
