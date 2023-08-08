//
//  AuthorizationManager.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 03.08.2023.
//

import Foundation

enum APIRequestError: Error {
    case notAuthorized
    case wrongResponseType
    case requestFailed(statusCode: Int)
    case noImageFound
}

protocol Authorization {
    var authorized: Bool { get }
    var accessTokenString: String { get }
}

final class AuthorizationManager: Authorization {
    
    var url = APIConstants.URLs.authorizationURL
    let query = [
        "client_id": APIConstants.IDs.clientID,
        "client_secret": APIConstants.IDs.clientSecret,
        "grant_type": "client_credentials"
    ]
    private var accessToken: AccessToken?
    
    var accessTokenString: String {
        guard let accessToken else { return "" }
        return accessToken.token
    }
    
    var authorized: Bool = false
    
    init() {
        setupAccessToken()
    }
    
    func setupAccessToken() {
        if let token = AccessToken.load() {
            accessToken = token
            authorized = true
        } else {
            Task {
                do {
                    accessToken = try await makeAccessToken()
                    authorized = true
                    accessToken?.save()
                } catch let error {
                    print("Access token loading error: \(error)")
                }
            }
            //                accessToken = try? await makeAccessToken()
            
        }
    }
    
    func makeAccessToken() async throws -> AccessToken {
        let request = authorizationRequest()
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else { throw APIRequestError.wrongResponseType }
        guard httpResponse.statusCode == 200 else { throw APIRequestError.requestFailed(statusCode: httpResponse.statusCode) }
        
        let accessToken = try JSONDecoder().decode(AccessToken.self, from: data)
        return accessToken
        
        
    }
    
    func authorizationRequest() -> URLRequest {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        let url = components.url!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
    
}
