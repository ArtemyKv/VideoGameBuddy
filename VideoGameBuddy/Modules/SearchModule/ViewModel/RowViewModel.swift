//
//  RowViewModel.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 04.08.2023.
//

import Foundation
import UIKit.UIImage

final class RowViewModel: ObservableObject {
    var game: Game
    var imageLoader: ImageLoadable!
    
    var name: String = ""
    
    var releaseDate: String = ""
    
    var platform: String = ""
    
    @Published var image: UIImage = UIImage(systemName: "photo")!
    
    init(game: Game) {
        self.game = game
        setup()
    }
    
    private func setup() {
        name = game.name
        releaseDate = releaseDateString() ?? ""
        platform = platformString()
        getImage()
    }
    
    private func releaseDateString() -> String? {
        guard let releaseDate = game.releaseDate else { return nil }
        let date = Date(timeIntervalSince1970: releaseDate)
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
    
    func getImage() {
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

extension RowViewModel: Equatable {
    static func == (lhs: RowViewModel, rhs: RowViewModel) -> Bool {
        lhs.game == rhs.game
    }
    
    
}
