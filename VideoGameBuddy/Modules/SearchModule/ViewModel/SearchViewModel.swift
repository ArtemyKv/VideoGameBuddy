//
//  SearchViewModel.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 02.08.2023.
//

import Foundation
import Combine

protocol SearchViewModelProtocol {
    var rowViewModels: [RowViewModel] { get }
    
    func makeSearch(with searchText: String)
}

final class SearchViewModel: ObservableObject {
    let networkService: APIService
    let imageLoader: ImageLoadable
    let builder: MainBuilder
    
    var searchTask: Task<Void, Never>? = nil
    
    @Published private var searchResults: [Game] = []
    
    @Published var rowViewModels: [RowViewModel] = []
    @Published var showErrorAlert: Bool = false
    
    private var subscriptions = Set<AnyCancellable>()
    
    
    init(networkService: APIService, imageLoader: ImageLoadable, builder: MainBuilder) {
        self.networkService = networkService
        self.imageLoader = imageLoader
        self.builder = builder
        setBindings()
    }
    
    private func setBindings() {
        $searchResults
            .receive(on: DispatchQueue.main)
            .sink { results in
                self.rowViewModels = results.map { self.builder.rowViewModel(game: $0) }
            }
            .store(in: &subscriptions)
    }
    
    @MainActor
    func makeSearch(with searchText: String) {
        searchTask?.cancel()
        searchTask = Task(operation: {
            do {
                await imageLoader.clearImagesStorage()
                let searchResults = try await networkService.searchGames(searchText: searchText)
                self.searchResults = searchResults
            } catch let error {
                print(error)
                showErrorAlert = true
                searchResults = []
            }
            
        })
    }
    
    func detailViewModel(forRowViewModel rowViewModel: RowViewModel) -> DetailsViewModel {
        let game = rowViewModel.game
        return builder.detailsViewModel(game: game)
    }
}
