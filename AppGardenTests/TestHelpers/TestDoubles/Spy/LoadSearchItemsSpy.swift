//
//  LoadSearchItemsSpy.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 25/08/23.
//

import Foundation
@testable import AppGarden

final class LoadSearchItemsSpy: LoadSearchItems {
    var completions: [(LoadSearchItems.Result) -> Void] = []
    var queries: [String] = []

    func search(query: String, completion: @escaping (LoadSearchItems.Result) -> Void) {
        completions.append(completion)
        queries.append(query)
    }

    func complete(with result: Result<[AppGarden.SearchItemResponse], AppGarden.DomainError>, at index: Int = 0) {
        completions[index](result)
    }
}
