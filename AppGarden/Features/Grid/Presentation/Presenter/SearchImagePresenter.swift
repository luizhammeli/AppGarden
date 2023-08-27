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
            delegate?.showError()
            return
        }

        delegate?.showLoader(isLoading: true)
        serchLoader.search(query: query) { [weak self] result in
            guard let self = self else { return }
            self.delegate?.showLoader(isLoading: false)

            switch result {
            case .success(let items):
                if items.isEmpty {
                    self.delegate?.showError()
                } else {
                    self.delegate?.view(items: self.mapSuccessResult(items: items))
                }
            case .failure:
                self.delegate?.showError()
            }
        }
    }

    private func mapSuccessResult(items: [SearchItemResponse]) -> [SearchImageViewModel] {
        return items.enumerated().map { index, item in
            let url = URL(string: item.media.imageURL)
            let size = HTMLSizeMapper.map(description: item.description)
            let strDate = item.dateTaken.formatToDefault()
            let accessibilityTitle = makeAccessibilityTitle(index: index, totalOfItems: items.count, title: item.title)

            return SearchImageViewModel(imageURL: url,
                                        size: size,
                                        title: item.title,
                                        accessibilityTitle: accessibilityTitle,
                                        tags: item.tags,
                                        author: item.author,
                                        date: strDate)
        }
    }

    private func makeAccessibilityTitle(index: Int, totalOfItems: Int, title: String) -> String {
        return "\(L10n.accessibilityItemName) \(index + 1) \(L10n.accessibilityItemOf) \(totalOfItems) \(L10n.accessibilityItemTitleName) \(title)"
    }
}
