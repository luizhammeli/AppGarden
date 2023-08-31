//
//  SearchProvider.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 24/08/23.
//

import Foundation
import LHNetworkClient

struct SearchProvider: HttpClientProvider {
    var url: URL
    var method: LHNetworkClient.Method
    var cancelPreviousRequests: Bool = true
    let query: String

    init(url: URL, query: String) {
        self.url = url
        self.method = .GET
        self.query = query
    }

    var baseURL: String?

    var queryParams: [String: String]? {
        ["format": "json", "nojsoncallback": "1", "tags": query]
    }

    var headers: [String: String]?

    var body: [String: Any]?

    var jsonDecoder: JSONDecoder? {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: .zero)
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
}
