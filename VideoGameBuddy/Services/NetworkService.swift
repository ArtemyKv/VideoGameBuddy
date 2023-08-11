//
//  NetworkService.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 03.08.2023.
//

import Foundation
import UIKit.UIImage

protocol APIService {
    init(authManager: Authorization)
        
    func searchGames(searchText: String) async throws -> [Game]
}

enum Endpoint: String {
    case games = "/games"
}

final class NetworkService: APIService {
    var authorizationManager: Authorization
    var authorizationHeaders: [String: String] {
        guard authorizationManager.authorized else { return [:] }
        return ["Client-ID": APIConstants.IDs.clientID, "Authorization": "Bearer " + authorizationManager.accessTokenString]
    }
    
    var baseURL = APIConstants.URLs.apiURL
    
    init(authManager: Authorization) {
        self.authorizationManager = authManager
    }
    
    func searchGames(searchText: String) async throws -> [Game] {
        guard authorizationManager.authorized else { throw APIRequestError.notAuthorized }
        
        let body = "fields name, cover.*, first_release_date, genres.*, platforms.*, rating, summary, storyline; limit 30; search \"\(searchText)\";"
        let request = urlRequest(endpoint: .games, body: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else { throw APIRequestError.wrongResponseType }
        guard httpResponse.statusCode == 200 else { throw APIRequestError.requestFailed(statusCode: httpResponse.statusCode) }
        
        let games = try JSONDecoder().decode([Game].self, from: data)
        return games
    }
    
    private func urlRequest(endpoint: Endpoint, body: String) -> URLRequest {
        let url = baseURL.appendingPathComponent(endpoint.rawValue)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body.data(using: .utf8, allowLossyConversion: false)
        request.allHTTPHeaderFields = authorizationHeaders
        return request
    }
}

final class PreviewNetworkService: APIService {
    
    init(authManager: Authorization) {
        //empty for preview
    }
        
    func searchGames(searchText: String) async throws -> [Game] {
        let games = Game.previewList
        return games
    }
}
