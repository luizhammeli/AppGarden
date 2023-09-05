//
//  DetailView.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 04/09/23.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var controller: DetailController

    init(controller: DetailController) {
        self.controller = controller
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.extraLarge) {
                AsyncImage(url: controller.viewModel?.url) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: controller.viewModel?.size.width,
                               height: controller.viewModel?.size.height)
                        .clipped()
                        .cornerRadius(BorderRadius.medium)
                        .shadow(radius: 3.5, x: 0, y: 5)
                } placeholder: {}

                InfoContainerView(items: controller.viewModel?.items)

            }.padding(.horizontal, Spacing.xxLarge)
            .navigationTitle(L10n.detailsScreenTitle)
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, Spacing.xxLarge)
        }
    }
}

final class DetailController: ObservableObject {
    let presenter: ImageDetailPresenterProtocol
    @Published var viewModel: ImageDetailViewModel?
    
    init(presenter: ImageDetailPresenterProtocol) {
        self.presenter = presenter
        self.viewModel = presenter.viewModel
    }
}

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

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let url = URL(string: "https:\\live.staticflickr.com/65535/52878785248_4833bdefd8_m.jpg")
        let presenter = ImageDetailPresenter(image: UIImage(), viewModel: .init(imageURL: url,
                                                                                size: .init(width: 240, height: 160),
                                                                                title: "Saosin New York",
                                                                                accessibilityTitle: "",
                                                                                tags: "Saosin",
                                                                                author: "198245544",
                                                                                date: "08/09/2023"))
        DetailView(controller: DetailController(presenter: presenter))
    }
}
