//
//  MainQueueDispatchDecorator+ImageLoader.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 31/08/23.
//

import Foundation

extension MainQueueDispatchDecorator: ImageLoader where T: ImageLoader {
    func load(url: URL?, completion: @escaping (Data?) -> Void) {
        instance.load(url: url) { [weak self] data in
            self?.dispatch { completion(data) }
        }
    }
}
