//
//  AccessToken.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 03.08.2023.
//

import Foundation

struct AccessToken: Codable {
    static let userDefaultsKey = "AccessToken"
    
    var token: String
    var expireDate: Int
    
    enum CodingKeys: String, CodingKey {
        case token = "access_token"
        case expireDate = "expires_in"
    }
    
    func save() {
        let tokenData = try? JSONEncoder().encode(self)
        UserDefaults.standard.set(tokenData, forKey: AccessToken.userDefaultsKey)
    }
    
    static func load() -> Self? {
        if let tokenData = UserDefaults.standard.object(forKey: AccessToken.userDefaultsKey) as? Data,
           let token = try? JSONDecoder().decode(AccessToken.self, from: tokenData) {
            return token
        } else {
            return nil
        }
    }
}
