//
//  NetworkService.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 03.08.2023.
//

import Foundation

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
        return ["Client-ID": APIConstants.IDs.clientID, "Authorization": authorizationManager.accessTokenString]
    }
    
    var baseURL = APIConstants.URLs.apiURL
    
    init(authManager: Authorization) {
        self.authorizationManager = authManager
    }
    
    func searchGames(searchText: String) async throws -> [Game] {
        guard authorizationManager.authorized else { throw APIRequestError.notAuthorized }
        
        let body = "fields name, cover.*, first_release_date, genres.*, platforms.*, rating, summary, storyline; limit 30; search \(searchText)"
        let request = urlRequest(endpoint: .games, body: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw APIRequestError.requestFailed }
        let games = try JSONDecoder().decode([Game].self, from: data)
        return games
    }
    
    private func urlRequest(endpoint: Endpoint, body: String) -> URLRequest {
        let url = baseURL.appendingPathComponent(endpoint.rawValue)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body.data(using: .utf8)
        request.allHTTPHeaderFields = authorizationHeaders
        return request
    }
    
//    func getImage(imageID: String) async throws ->
}
