//
//  MainQueueDispatchDecorator+LoadSearchItems.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 23/08/23.
//

import Foundation

extension MainQueueDispatchDecorator: LoadSearchItems where T: LoadSearchItems {
    func search(query: String, completion: @escaping (Result<[SearchItemResponse], DomainError>) -> Void) {
        instance.search(query: query) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}
