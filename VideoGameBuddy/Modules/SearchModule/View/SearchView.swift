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
    @State private var layoutStyle: LayoutStyle = .list
    
    enum LayoutStyle: String, CaseIterable, Identifiable {
        case list = "list.bullet"
        case grid = "rectangle.grid.3x2"
        
        var id: String { return rawValue }
    }
    
    private let gridColumns = [GridItem(), GridItem()]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            if layoutStyle == .list {
                LazyVStack {
                    ForEach(viewModel.rowViewModels, id: \.game) { rowViewModel in
                        ListGameRow(rowViewModel: rowViewModel)
                            .frame(height: 150)
                    }
                }
            } else {
                LazyVGrid(columns: gridColumns) {
                    ForEach(viewModel.rowViewModels, id:\.game) { rowViewModel in
                        GridGameRow(rowViewModel: rowViewModel)
                    }
                }
                .padding(.horizontal, 8)
            }
        }
        .navigationTitle("Video Game Buddy")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Start searching games")
        .onSubmit(of: .search) {
            viewModel.makeSearch(with: searchText)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Picker("LayoutStyle", selection: $layoutStyle) {
                    ForEach(LayoutStyle.allCases) { style in
                        Image(systemName: style.rawValue).tag(style)
                    }
                }
                .pickerStyle(.segmented)
            }
        }
        
    }
}

struct SearchView_Perviews: PreviewProvider {
    static let authManager = AuthorizationManager()
    static let previewNetworkService = PreviewNetworkService(authManager: authManager)
    static let builder = MainBuilder()
    static let searchViewModel = SearchViewModel(networkService: previewNetworkService, builder: builder)
    static var previews: some View {
        NavigationView {
            SearchView(viewModel: searchViewModel)
        }
    }
}
