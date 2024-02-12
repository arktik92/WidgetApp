//
//  WidgetContentView.swift
//  WidgetApp
//
//  Created by Esteban SEMELLIER on 22/11/2023.
//

import SwiftUI

struct WidgetContentView: View {
    @StateObject var viewModel = QuoteViewModel()
    var body: some View {
        ZStack {
            viewModel.quoteBackgroundColor()
                .ignoresSafeArea()
            VStack {
                Text(viewModel.day)
                    .font(.title3)
                    .foregroundColor(viewModel.quoteTextColor())
                Spacer()
                Text(viewModel.quote.quote)
                    .font(.callout)
                    .foregroundColor(viewModel.quoteTextColor())
                    .lineLimit(2)                        .truncationMode(.tail)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                Text(viewModel.quote.author)
                    .font(.caption2)
                    .foregroundColor(viewModel.quoteTextColor())
                Spacer()
            }
            .padding()
        }
    }
}

struct WidgetContentView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetContentView()
    }
}
