//
//  RemoteLoadSearchItems.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 23/08/23.
//

import Foundation
import LHNetworkClient

protocol LoadSearchItems {
    func search(query: String, completion: @escaping (Result<[SearchItemReponse], DomainError>) -> Void)
}

final class RemoteLoadSearchItems: LoadSearchItems {
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func search(query: String, completion: @escaping (Result<[SearchItemReponse], DomainError>) -> Void) {
        let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne")! // TODO: Remove force unwrapping
        let provider = SearchProvider(url: url, query: query)
        client.fetch(provider: provider) { result in
            let result: Result<SearchResponse, HttpError> = result
            switch result {
            case .success(let searchResponse):
                completion(.success(searchResponse.items))
            case .failure:
                completion(.failure(.unexpected))
            }
        }
    }
}

struct SearchProvider: HttpClientProvider {
    var url: URL
    var method: LHNetworkClient.Method
    let query: String
    
    init(url: URL, query: String) {
        self.url = url
        self.method = .GET
        self.query = query
    }
    
    var baseURL: String?
    
    var queryParams: [String : String]? {
        ["format": "json", "nojsoncallback": "1", "tags": query]
    }
    
    var headers: [String : String]?
    
    var body: [String : Any]?
    
    var jsonDecoder: JSONDecoder? {
        JSONDecoder()
    }
}

import Foundation

public enum DomainError: Error {
    case unexpected
}
