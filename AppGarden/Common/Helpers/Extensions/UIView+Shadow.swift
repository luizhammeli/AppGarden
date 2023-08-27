//
//  UIView+Shadow.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 27/08/23.
//

import UIKit

extension UIView {
    func applyShadow(
        color: UIColor,
        offset: CGSize = CGSize(width: 0.0, height: 5.0),
        opacity: Float = 0.5,
        radius: CGFloat = 3.5,
        shadowPath: CGPath? = nil
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = Float(opacity)
        layer.masksToBounds = false
        if let shadowPath = shadowPath {
            layer.shadowPath = shadowPath
        }
    }
}
