//
//  DefaultThrottler.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 29/08/23.
//

import Foundation

protocol Throttler {
    func throttle(completion: @escaping () -> Void)
    func cancel()
}

final class DefaultThrottler: Throttler {
    private var workItem: DispatchWorkItem?
    private let queue: DispatchQueue
    private let delay: TimeInterval

    init(delay: TimeInterval = 0.5, queue: DispatchQueue = DispatchQueue.main) {
        self.delay = delay
        self.queue = queue
    }

    func throttle(completion: @escaping () -> Void) {
        cancel()

        let item = DispatchWorkItem { completion() }
        self.workItem = item

        queue.asyncAfter(deadline: .now() + Double(delay), execute: item)
    }

    func cancel() {
        workItem?.cancel()
    }
}
