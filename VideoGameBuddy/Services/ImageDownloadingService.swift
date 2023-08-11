//
//  ImageDownloadingService.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 08.08.2023.
//

import Foundation
import UIKit.UIImage

final class ImageDownloadingService {
    
    let baseURL = APIConstants.URLs.imagesURL
    
    var cachedImages: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 50
        return cache
    }()
    
    var imageDownloadingTasks: [String: Task<UIImage, Error>] = [:]
    
    func getImage(imageID: String) async throws -> UIImage {
        let cacheKey = NSString(string: imageID)
        if let image = cachedImage(for: cacheKey) { return image }
        
        let task = Task {
            let image = try await downloadImage(imageID: imageID)
            return image
        }
        imageDownloadingTasks[imageID] = task
        let image = try await task.value
        return image
        
    }
    
    private func cachedImage(for imageID: NSString) -> UIImage? {
        return cachedImages.object(forKey: imageID)
    }
    
    private func downloadImage(imageID: String) async throws -> UIImage {
        let endpoint = "/t_cover_big/\(imageID).jpg"
        let url = baseURL.appendingPathComponent(endpoint)
        
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else { throw APIRequestError.noImageFound }
        return image
        
    }
    
}
