//
//  ErrorView.swift
//  AppGarden
//
//  Created by Luiz Diniz Hammerli on 01/09/23.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        VStack(spacing: Spacing.small) {
            Text(L10n.searchErrorTitle).font(.system(size: FontSizeConstants.medium, weight: .bold))
            Text(L10n.searchErrorDescription).foregroundColor(.secondary)
        }.padding(.bottom, Padding.xxLarge)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
