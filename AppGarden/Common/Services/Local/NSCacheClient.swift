//
//  NSCacheClient.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 31/08/23.
//

import Foundation

protocol CacheClient {
    func fetch(with key: String) -> DataCache?
    func save(key: String, data: Data)
    func remove(key: String)
}

final class NSCacheClient: CacheClient {
    let cache: NSCache<NSString, DataCache>

    init(cache: NSCache<NSString, DataCache>) {
        self.cache = cache
    }
    
    func fetch(with key: String) -> DataCache? {
        return cache.object(forKey: NSString(string: key))
    }
    
    func save(key: String, data: Data) {
        let dataCache = DataCache(key: key, value: data, date: Date())
        cache.setObject(dataCache, forKey: NSString(string: key))
    }
    
    func remove(key: String) {
        cache.removeObject(forKey: NSString(string: key))
    }
}
    
final class DataCache {
    let key: String
    let date: Date
    let value: Data
    
    init(key: String, value: Data, date: Date) {
        self.key = key
        self.date = date
        self.value = value
    }
}
