//
//  NavigationControllerSpy.swift
//  AppGardenTests
//
//  Created by Luiz Diniz Hammerli on 25/08/23.
//

import UIKit

final class NavigationControllerSpy: UINavigationController {
    var controllers: [UIViewController] = []
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        controllers.append(viewController)
    }
}
