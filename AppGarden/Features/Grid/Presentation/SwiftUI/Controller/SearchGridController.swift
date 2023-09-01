//
//  SearchGridController.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 01/09/23.
//

import SwiftUI

final class SearchGridController: ObservableObject {
    private let presenter: SearchImagePresenter
    @Published var items: [SearchImageViewModel] = []
    @Published var isLoading: Bool = false
    
    init(presenter: SearchImagePresenter) {
        self.presenter = presenter
        presenter.delegate = self
    }
    
    func search(query: String) {
        presenter.makeSearch(query: query)
    }
}

extension SearchGridController: SearchPresenterDelegateProtocol {
    func view(items: [SearchImageViewModel]) {
        self.items = items
    }
    
    func showLoader(isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    func showError() {
        self.items = []
    }
}
