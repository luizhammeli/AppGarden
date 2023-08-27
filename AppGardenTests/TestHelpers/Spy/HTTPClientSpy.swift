//
//  HTTPClientSpy.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 24/08/23.
//

import LHNetworkClient
import Foundation
@testable import AppGarden

final class HTTPClientSpy: HTTPClient {
    var providers: [LHNetworkClient.HttpClientProvider] = []
    private var completions: [(Result<SearchResponse, LHNetworkClient.HttpError>) -> Void] = []

    func fetch<T>(provider: LHNetworkClient.HttpClientProvider,
                  completion: @escaping (Result<T, LHNetworkClient.HttpError>) -> Void) where T: Decodable, T: Encodable {
        providers.append(provider)
        completions.append(completion as? (Result<SearchResponse, LHNetworkClient.HttpError>) -> Void ?? { _ in })
    }

    func complete(with result: Result<SearchResponse, LHNetworkClient.HttpError>, at index: Int = 0) {
        completions[index](result)
    }
}
