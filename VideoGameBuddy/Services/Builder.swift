//
//  Builder.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 06.08.2023.
//

import Foundation

protocol Builder: ObservableObject {
    func searchViewModel() -> SearchViewModel
    func rowViewModel(game: Game) -> RowViewModel
}

class MainBuilder: Builder {
    
    let authManager: Authorization = AuthorizationManager()
    lazy var networkService: APIService = NetworkService(authManager: authManager)
    
    func searchViewModel() -> SearchViewModel {
        let searchViewModel = SearchViewModel(networkService: networkService, builder: self)
        return searchViewModel
    }
    
    func rowViewModel(game: Game) -> RowViewModel {
        let rowViewModel = RowViewModel(game: game)
        rowViewModel.networkService = networkService
        return rowViewModel
    }
}
