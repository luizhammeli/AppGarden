//
//  SearchResponse.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 23/08/23.
//

import Foundation

struct SearchResponse: Codable, Equatable {
    let items: [SearchItemResponse]
}

struct SearchItemResponse: Codable, Equatable {
    let title: String
    let description: String
    let tags: String
    let author: String
    let dateTaken: Date
    let link: String
    let media: MediaReponse

    enum CodingKeys: String, CodingKey {
        case title, description, tags, author, media, link
        case dateTaken = "date_taken"
    }
}

struct MediaReponse: Codable, Equatable {
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "m"
    }
}
