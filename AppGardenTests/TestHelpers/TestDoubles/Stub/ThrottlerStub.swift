//
//  ThrottlerStub.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 29/08/23.
//

import Foundation
@testable import AppGarden

final class ThrottlerStub: Throttler {
    func throttle(completion: @escaping () -> Void) {
        completion()
    }
    
    func cancel() {}
}
