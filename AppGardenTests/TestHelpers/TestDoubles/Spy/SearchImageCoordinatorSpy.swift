//
//  SearchImageCoordinatorSpy.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 26/08/23.
//

import UIKit
@testable import AppGarden

final class SearchImageCoordinatorSpy: SearchImageCoordinatorProtocol {
    var receivedData: [(image: UIImage?, viewModel: AppGarden.SearchImageViewModel?)] = []

    func goToDetail(image: UIImage?, viewModel: AppGarden.SearchImageViewModel?) {
        receivedData.append((image: image, viewModel: viewModel))
    }
}
