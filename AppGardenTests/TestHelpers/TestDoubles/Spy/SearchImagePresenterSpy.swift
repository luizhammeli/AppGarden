//
//  SearchImagePresenterSpy.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 26/08/23.
//

import Foundation
@testable import AppGarden

final class SearchImagePresenterSpy: SearchImagePresenterProtocol {
    var queries: [String] = []

    func makeSearch(query: String) {
        queries.append(query)
    }
}
