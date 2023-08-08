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
    var networkService: APIService!
    private var imageLoadingTask: Task<Void, Never>?
    
    var name: String = ""
    
    var releaseDate: String = ""
    
    var platform: String = ""
    
    @Published var image: UIImage = UIImage(systemName: "photo")!
    
    init(game: Game) {
        self.game = game
        setup()
    }
    
    deinit {
        imageLoadingTask?.cancel()
    }
    
    private func setup() {
        name = game.name
        releaseDate = releaseDateString() ?? ""
        platform = platformString()
        getImage()
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
    
    func getImage() {
        guard let imageID = game.coverID else { return }
        imageLoadingTask = Task { @MainActor in
            do {
                self.image = try await networkService.getImage(imageID: imageID)
            } catch let error {
                print(error)
            }
        }
    }
}
