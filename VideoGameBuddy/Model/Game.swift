//
//  Game.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 03.08.2023.
//

import Foundation

struct Game: Codable, Hashable {
    
    var id: Int
    var name: String
    var genres: [Genre]
    var platforms: [Platform]
    var releaseDate: Int?
    var coverID: String?
    var summary: String
    var storyline: String
    var rating: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case genres
        case platforms
        case releaseDate = "first_release_date"
        case coverID = "cover"
        case summary
        case storyline
        case rating
    }
    
    enum CoverCodingKeys: String, CodingKey {
        case coverID = "image_id"
    }
    
    init(from decoder: Decoder) throws {
        let mainContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try mainContainer.decode(Int.self, forKey: .id)
        self.name = try mainContainer.decode(String.self, forKey: .name)
        self.genres = (try? mainContainer.decode([Genre].self, forKey: .genres)) ?? []
        self.platforms = (try? mainContainer.decode([Platform].self, forKey: .platforms)) ?? []
        self.releaseDate = try? mainContainer.decode(Int.self, forKey: .releaseDate)
        self.summary = (try? mainContainer.decode(String.self, forKey: .summary)) ?? ""
        self.storyline = (try? mainContainer.decode(String.self, forKey: .storyline)) ?? ""
        self.rating = try? mainContainer.decode(Double.self, forKey: .rating)
        
        if let coverContainer = try? mainContainer.nestedContainer(keyedBy: CoverCodingKeys.self, forKey: .coverID) {
            self.coverID = try coverContainer.decode(String.self, forKey: .coverID)
        }
    }
}

extension Game {
    static var preview: Self {
        let decoder = JSONDecoder()
        let gameDataURL = Bundle.main.url(forResource: "gameExample", withExtension: "json")!
        let gameData = try! Data(contentsOf: gameDataURL)
        let previewGame = try! decoder.decode(Game.self, from: gameData)
        return previewGame
    }
    
    static var previewList: [Self] {
        let decoder = JSONDecoder()
        let gameDataURL = Bundle.main.url(forResource: "gamesListPreview", withExtension: "json")!
        let gameData = try! Data(contentsOf: gameDataURL)
        let previewGame = try! decoder.decode([Game].self, from: gameData)
        return previewGame
    }
}
