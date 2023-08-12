//
//  DetailsViewModel.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 02.08.2023.
//

import Foundation
import UIKit.UIImage

final class DetailsViewModel: ObservableObject {
    var game: Game
    
    var imageLoader: ImageLoadable!
    
    var name: String = ""
    var releaseDate: String = ""
    var genres: String = ""
    var platforms: String = ""
    var summary: String = ""
    var storyline: String = ""
    var rating: Int = 0
    
    var rowTitles = ["Genres", "Platforms", "Summary", "Storyline"]
    
    @Published var image: UIImage = UIImage(systemName: "photo")!
    
    init(game: Game) {
        self.game = game
        configure()
    }
    
    private func configure() {
        getImage()
        name = game.name
        releaseDate = Date(timeIntervalSince1970: game.releaseDate!).formatted(date: .long, time: .omitted)
        genres = makeGenresString()
        platforms = makePlatformsString()
        summary = game.summary
        storyline = game.storyline
        rating = Int(game.rating ?? 0)
    }
    
    private func makeGenresString() -> String {
        guard game.genres.count > 0 else { return "Genre unknown" }
        let genresString = game.genres.map { $0.name }.joined(separator: ", ")
        return genresString
    }
    
    private func makePlatformsString() -> String {
        guard game.platforms.count > 0 else { return "No platforms" }
        let platformsString = game.platforms.map { $0.name }.joined(separator: ",\n")
        return platformsString
    }
    
    private func makeRatingString() -> String {
        guard let rating = game.rating else { return "n/a"}
        let ratingString = String(Int(rating))
        return ratingString
    }
    
    private func getImage() {
        guard let imageID = game.coverID else { return }
        Task { @MainActor in
            do {
                self.image = try await imageLoader.fetch(withImageID: imageID)
            } catch let error {
                print(error)
            }
        }
    }
    
}
