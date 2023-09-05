//
//  GridView.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 01/09/23.
//

import SwiftUI

struct GridView: View {
    var items: [SearchImageViewModel] = []
    let layoutMapper: GridViewFlowLayoutDataSourceProtocol
    
    var body: some View {
        GeometryReader(content: { proxy in
            ScrollView {
                LazyVGrid (columns: getGridColumns(proxy.size.width), spacing: Spacing.superSmall, content: {
                    ForEach(items, id: \.imageURL) { item in
                        NavigationLink {
                            DependencyContainer().makeImageDetailView(viewModel: item)
                        } label: {
                            AsyncImage(url: item.imageURL) { image in
                                image.resizable()
                                    .scaledToFill()
                                    .frame(width: getGridSize(proxy.size.width).width,
                                           height: getGridSize(proxy.size.width).height)
                                    .clipped()
                            } placeholder: {}
                        }
                    }
                })
            }
        })
    }
    
    private func getGridSize(_ parentWidth: CGFloat) -> CGSize {
        return layoutMapper.cellSize(
            width: parentWidth,
            verticalSize: .regular
        )
    }
    
    private func getGridColumns(_ parentWidth: CGFloat) -> [GridItem] {
        let width = getGridSize(parentWidth).width
        return [GridItem(.adaptive(minimum: width), spacing: Spacing.superSmall)]
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(items: [], layoutMapper: SearchImageLayoutDataSource())
    }
}
