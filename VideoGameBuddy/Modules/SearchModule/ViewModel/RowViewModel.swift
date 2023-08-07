//
//  RowViewModel.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 04.08.2023.
//

import Foundation
import SwiftUI

final class RowViewModel {
    var game: Game
    
    var name: String = ""
    
    var releaseDate: String = ""
    
    var platform: String = ""
    
    var image: Image {
        gameImage ?? Image(systemName: "photo")
    }
    
    private var gameImage: Image?
    
    init(game: Game) {
        self.game = game
        setup()
    }
    
    private func setup() {
        name = game.name
        releaseDate = releaseDateString() ?? ""
        platform = platformString()
    }
    
    private func releaseDateString() -> String? {
        guard let releaseDate = game.releaseDate else { return nil }
        let date = Date(timeIntervalSince1970: Double(releaseDate))
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        return formatter.string(from: date)
    }
    
    private func platformString() -> String {
        guard game.platforms.count > 0 else { return "" }
        var platfomrsString = ""
        platfomrsString = game.platforms
            .reduce("", { partialResult, platform in
                partialResult + " " + platform.name + " \\"
            })
        platfomrsString.removeLast()
        return platfomrsString
    }
}
