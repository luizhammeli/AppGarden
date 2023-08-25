//
//  DelegateSpy.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 25/08/23.
//

import Foundation
@testable import AppGarden

enum DelegateMessage: Equatable {
    case view(items: [AppGarden.SearchImageViewModel])
    case loader(isLoading: Bool)
    case error
}

final class DelegateSpy: SearchPresenterDelegateProtocol {
    var messages: [DelegateMessage] = []
    
    func view(items: [AppGarden.SearchImageViewModel]) {
        messages.append(.view(items: items))
    }
    
    func showLoader(isLoading: Bool) {
        messages.append(.loader(isLoading: isLoading))
    }
    
    func showError() {
        messages.append(.error)
    }
}
