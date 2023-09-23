//
//  SearchImageViewModel.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 23/08/23.
//

import UIKit

struct SearchImageViewModel: Equatable {
    let imageURL: URL?
    let size: CGSize
    let title: String
    let link: String
    let accessibilityTitle: String
    let tags: String
    let author: String
    let date: String
}
