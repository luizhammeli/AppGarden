//
//  ImageDetailFactory.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 05/09/23.
//

import Foundation
import UIKit

protocol ImageDetailFactory {
    func makeSearchImageViewController(image: UIImage, viewModel: SearchImageViewModel) -> ImageDetailViewController
}

extension DependencyContainer: ImageDetailFactory {
    func makeSearchImageViewController(image: UIImage, viewModel: SearchImageViewModel) -> ImageDetailViewController {
        let presenter = ImageDetailPresenter(image: image, viewModel: viewModel)
        return ImageDetailViewController(presenter: presenter)
    }

    func makeImageDetailView(viewModel: SearchImageViewModel) -> DetailView {
        let presenter = ImageDetailPresenter(image: UIImage(), viewModel: viewModel)
        let controller = DetailController(presenter: presenter)
        return DetailView(controller: controller)
    }
}
