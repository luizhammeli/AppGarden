//
//  ImageDetailPresenter.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 24/08/23.
//

import UIKit

protocol ImageDetailPresenterProtocol {
    var viewModel: ImageDetailViewModel? { get }
}

final class ImageDetailPresenter: ImageDetailPresenterProtocol {
    var viewModel: ImageDetailViewModel?

    init(image: UIImage, viewModel: SearchImageViewModel) {
        mapData(image: image, viewModel: viewModel)
    }
    
    private func mapData(image: UIImage, viewModel: SearchImageViewModel) {
        let strWidth = String(Int(viewModel.size.width))
        let strHeight = String(Int(viewModel.size.height))
        let items = [ImageItemViewModel(title: L10n.imageTitle, value: viewModel.title),
                     ImageItemViewModel(title: L10n.imageDate, value: viewModel.date),
                     ImageItemViewModel(title: L10n.imageHeight, value: strHeight),
                     ImageItemViewModel(title: L10n.imageWidth, value: strWidth)]
        self.viewModel = ImageDetailViewModel(items: items, image: image, size: viewModel.size)
    }
}

struct ImageDetailViewModel {
    let items: [ImageItemViewModel]
    let image: UIImage
    let size: CGSize
}

struct ImageItemViewModel {
    let title: String
    let value: String
}
