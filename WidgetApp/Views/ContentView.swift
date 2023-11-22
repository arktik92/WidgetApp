//
//  ContentView.swift
//  WidgetApp
//
//  Created by Esteban SEMELLIER on 22/11/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = QuoteViewModel()
    
    var body: some View {
        ZStack {
            viewModel.quoteBackgroundColor()
                .ignoresSafeArea()
            VStack {
                Text(viewModel.day)
                    .font(.title)
                    .foregroundColor(viewModel.quoteTextColor())
                Spacer()
                Text(viewModel.quote.quote)
                    .font(.title3)
                    .foregroundColor(viewModel.quoteTextColor())
                Text(viewModel.quote.author)
                    .font(.caption)
                    .foregroundColor(viewModel.quoteTextColor())
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
