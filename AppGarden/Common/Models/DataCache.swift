//
//  DataCache.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 31/08/23.
//

import Foundation

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
