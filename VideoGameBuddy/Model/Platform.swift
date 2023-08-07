//
//  Platform.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 03.08.2023.
//

import Foundation

struct Platform: Codable, Hashable {
    var id: Int
    var name: String
    var logoID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case logoID = "platform_logo"
    }
}
