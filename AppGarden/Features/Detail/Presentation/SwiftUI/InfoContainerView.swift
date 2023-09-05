//
//  InfoContainerView.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 05/09/23.
//

import SwiftUI

struct InfoContainerView: View {
    let items: [ImageItemViewModel]

    init(items: [ImageItemViewModel]?) {
        self.items = items ?? []
    }

    var body: some View {
        VStack(spacing: Spacing.superSmall) {
            ForEach(items, id: \.self) { InfoContainerRowView(viewModel: $0) }
        }.padding(.bottom, Spacing.small)
        .background(Color(UIColor.secondarySystemBackground))
         .cornerRadius(BorderRadius.small)
    }
}

struct InfoContainerView_Previews: PreviewProvider {
    static var previews: some View {
        InfoContainerView(items: [])
    }
}
