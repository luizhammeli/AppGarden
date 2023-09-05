//
//  InfoContainerRowView.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 05/09/23.
//

import SwiftUI

struct InfoContainerRowView: View {
    let viewModel: ImageItemViewModel

    init(viewModel: ImageItemViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            HStack {
                Text(viewModel.title)
                    .font(.system(size: FontSizeConstants.small))
                    .foregroundColor(Color(UIColor.secondaryLabel))
                Spacer()
                Text(viewModel.value).font(.system(size: FontSizeConstants.small, weight: .bold))
            }
            
            Color(UIColor.systemBackground).frame(height: 1).opacity(viewModel.isLastItem ? 0 : 1)
        }
        .padding(.top, Spacing.medium)
        .padding(.horizontal, Spacing.large)
    }
}

struct InfoContainerRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            InfoContainerRowView(viewModel: .init(title: "Test Title", value: "Test Value", isLastItem: false))
        }
        .padding(.bottom, Spacing.small)
        .background(Color(uiColor: .lightGray))
    }
}

