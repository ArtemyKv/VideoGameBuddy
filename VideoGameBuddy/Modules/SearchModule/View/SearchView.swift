//
//  SearchView.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 02.08.2023.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel
    
    @State private var searchText: String = ""
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVStack {
                ForEach(viewModel.rowViewModels, id: \.game) { rowViewModel in
                    ListGameRow(rowViewModel: rowViewModel)
                        .frame(height: 150)
                }
            }
                .navigationTitle("Video Game Buddy")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $searchText, prompt: "Start searching games")
                .onSubmit(of: .search) {
                    viewModel.makeSearch(with: searchText)
                }
        }
    }
}

struct SearchView_Perviews: PreviewProvider {
    static let builder = MainBuilder()
    static let searchViewModel = builder.searchViewModel()
    static var previews: some View {
        SearchView(viewModel: searchViewModel)
    }
}
