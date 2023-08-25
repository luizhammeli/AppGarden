//
//  RemoteLoadSearchItems.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 23/08/23.
//

import Foundation
import LHNetworkClient

protocol LoadSearchItems {
    typealias Result = Swift.Result<[SearchItemResponse], DomainError>
    func search(query: String, completion: @escaping (Result) -> Void)
}

final class RemoteLoadSearchItems: LoadSearchItems {
    private let client: HTTPClient
    private let baseURL: String
    
    init(client: HTTPClient, baseURL: String = Enviroment.baseURL) {
        self.baseURL = baseURL
        self.client = client
    }
    
    func search(query: String, completion: @escaping (LoadSearchItems.Result) -> Void) {
        guard let url = URL(string: baseURL) else { completion(.failure(.unexpected)); return }
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
