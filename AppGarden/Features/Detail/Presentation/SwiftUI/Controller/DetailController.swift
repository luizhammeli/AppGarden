//
//  DetailController.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 05/09/23.
//

import Foundation

final class DetailController: ObservableObject {
    let presenter: ImageDetailPresenterProtocol
    @Published var viewModel: ImageDetailViewModel?
    
    init(presenter: ImageDetailPresenterProtocol) {
        self.presenter = presenter
        self.viewModel = presenter.viewModel
    }
}
