//
//  SearchImageLayoutDataSource.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 26/08/23.
//

import UIKit

struct SearchImageLayoutDataSource: GridViewFlowLayoutDataSourceProtocol {
    var lineSpacing: CGFloat = Spacing.superSmall
    var itemSpacing: CGFloat = Spacing.superSmall
    
    func cellSize(width: CGFloat, verticalSize: UIUserInterfaceSizeClass) -> CGSize {
        let numberOfItems: CGFloat = verticalSize == .compact ? GridConstants.numberOfElementsLandscape : GridConstants.numberOfElementsPortrait
        let spacing: CGFloat = numberOfItems - 1
        let totalSpacing = Spacing.superSmall * spacing
        let size: CGFloat = (width - totalSpacing) / numberOfItems
        return CGSize(width: size, height: size)
    }
}
