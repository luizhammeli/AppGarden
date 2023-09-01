//
//  ImageLoaderProvider.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 31/08/23.
//

import Foundation
import LHNetworkClient

struct ImageLoaderProvider: HttpClientProvider {
    var url: URL
    
    var baseURL: String?
    
    var queryParams: [String : String]?
    
    var headers: [String : String]?
    
    var body: [String : Any]?
    
    var method: LHNetworkClient.Method = .GET
    
    var jsonDecoder: JSONDecoder? = JSONDecoder()
    
    var cancelPreviousRequests: Bool = false
    
    init(url: URL) {
        self.url = url
    }
}
