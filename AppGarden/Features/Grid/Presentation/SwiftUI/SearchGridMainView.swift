//
//  SearchGridView.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 01/09/23.
//

import SwiftUI
import LHNetworkClient

struct SearchGridMainView: View {
    private let layoutMapper: GridViewFlowLayoutDataSourceProtocol
    @State private var searchText = ""
    @ObservedObject private var controller: SearchGridController
    
    init(controller: SearchGridController, layoutMapper: GridViewFlowLayoutDataSourceProtocol) {
        self.controller = controller
        self.layoutMapper = layoutMapper
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if controller.isLoading {
                    ProgressView().controlSize(.large)
                } else if controller.items.isEmpty {
                    ErrorView()
                } else {
                    GridView(items: controller.items, layoutMapper: layoutMapper)
                }
            }
            .navigationTitle(L10n.gridViewTitle)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onChange(of: searchText) { _ in controller.search(query: searchText) }
        }
    }
}

struct SearchGridView_Previews: PreviewProvider {
    static var previews: some View {
        DependencyContainer().makeSearchGridView()
    }
}
