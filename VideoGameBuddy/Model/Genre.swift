//
//  Genre.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 03.08.2023.
//

import Foundation

struct Genre: Codable, Hashable {
    var id: Int
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
