//
//  Models.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 25/08/23.
//

import Foundation
@testable import AppGarden

func makeFakeSearchResponse() -> SearchResponse {
    return .init(items: [makeFakeSearchItemResponse()])
}

func makeFakeSearchItemResponse() -> SearchItemResponse {
    let description = "<img src=\"https://live.staticflickr.com/65535/53136382028_850cc2bb55_m.jpg\" width=\"160\" height=\"240\" alt=\"silhouette.with.airpods\" />"
    let item = SearchItemResponse(title: "title",
                                  description: description,
                                  tags: "1",
                                  author: "auth",
                                  dateTaken: Date(),
                                  media: .init(imageURL: "https://test.com"))
    return item
}

func makeFakeSearchImageViewModel(with itemResponse: SearchItemResponse) -> SearchImageViewModel {
    let url = URL(string: itemResponse.media.imageURL)
    return .init(imageURL: url,
                 size: CGSize(width: 160, height: 240),
                 title: itemResponse.title,
                 accessibilityTitle: "Item 1 Of 1 Title \(itemResponse.title)",
                 tags: itemResponse.tags,
                 author: itemResponse.author,
                 date: itemResponse.dateTaken.formatToDefault())
}
