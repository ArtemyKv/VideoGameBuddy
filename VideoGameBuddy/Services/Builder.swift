//
//  Builder.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 06.08.2023.
//

import Foundation

protocol Builder: ObservableObject {
    func searchViewModel() -> SearchViewModel
}

class MainBuilder: Builder {
    
    let authManager: Authorization = AuthorizationManager()
    lazy var networkService: APIService = NetworkService(authManager: authManager)
    
    func searchViewModel() -> SearchViewModel {
        let searchViewModel = SearchViewModel(networkService: networkService, builder: self)
        return searchViewModel
    }
}
