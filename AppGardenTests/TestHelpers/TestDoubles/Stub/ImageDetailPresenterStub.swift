//
//  ImageDetailPresenterStub.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 27/08/23.
//

import Foundation
@testable import AppGarden

final class ImageDetailPresenterStub: ImageDetailPresenterProtocol {
    var viewModel: AppGarden.ImageDetailViewModel?
    
    init(viewModel: AppGarden.ImageDetailViewModel) {
        self.viewModel = viewModel
    }
}
