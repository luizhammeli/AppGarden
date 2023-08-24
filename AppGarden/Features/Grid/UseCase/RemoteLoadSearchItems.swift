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
        guard let url = URL(string: Enviroment.baseURL) else { completion(.failure(.unexpected)); return }
        
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
