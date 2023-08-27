//
//  GridViewFlowLayoutDataSourceProtocol.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 26/08/23.
//

import UIKit

protocol GridViewFlowLayoutDataSourceProtocol {
    func cellSize(width: CGFloat, verticalSize: UIUserInterfaceSizeClass) -> CGSize
    var lineSpacing: CGFloat { get }
    var itemSpacing: CGFloat { get }
}
