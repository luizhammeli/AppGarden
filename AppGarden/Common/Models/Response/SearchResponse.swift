//
//  SearchResponse.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 23/08/23.
//

import Foundation

struct SearchResponse: Codable {
    let items: [SearchItemReponse]
}

struct SearchItemReponse: Codable {
    let title: String
    let description: String
    let tags: String
    let author: String
    let dateTaken: String
    let media: MediaReponse

    enum CodingKeys: String, CodingKey {
        case title, description, tags, author, media
        case dateTaken = "date_taken"
    }
}

struct MediaReponse: Codable {
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {        
        case imageURL = "m"
    }
}
