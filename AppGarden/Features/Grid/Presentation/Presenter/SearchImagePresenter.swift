//
//  SearchImagePresenter.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 23/08/23.
//

import Foundation

protocol SearchPresenterDelegateProtocol: AnyObject {
    func view(items: [SearchImageViewModel])
    func showLoader(isLoading: Bool)
    func showError()
}

protocol SearchImagePresenterProtocol {
    func makeSearch(query: String)
}

final class SearchImagePresenter: SearchImagePresenterProtocol {
    private let serchLoader: LoadSearchItems
    weak var delegate: SearchPresenterDelegateProtocol?
    
    init(serchLoader: LoadSearchItems) {
        self.serchLoader = serchLoader
    }
    
    func makeSearch(query: String) {
        guard !query.isEmpty else {
            delegate?.view(items: [])
            return
        }
        delegate?.showLoader(isLoading: true)
        serchLoader.search(query: query) { [weak self] result in
            DispatchQueue.main.async {
                self?.delegate?.showLoader(isLoading: false)
                switch result {
                case .success(let items):
                    if items.isEmpty {
                        self?.delegate?.showError()
                    } else {
                        self?.delegate?.view(items: items.map { .init(imageURL: URL(string: $0.media.imageURL)) })
                    }
                case .failure:
                    self?.delegate?.showError()
                }
            }
        }
    }
}
