//
//  ImageLoader.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 09.08.2023.
//

import Foundation
import UIKit.UIImage

protocol ImageLoadable: AnyObject {
    func fetch(withImageID imageID: String) async throws -> UIImage
    func fetch(_ url: URL) async throws -> UIImage
    func clearImagesStorage() async
    
}

actor ImageLoader: ImageLoadable {
    
    private let baseURL = APIConstants.URLs.imagesURL
    
    private var images: [URL: LoaderStatus] = [:]
    
    private var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 50
        return cache
    }()
    
    private enum LoaderStatus {
        case inProgress(Task<UIImage, Error>)
        case fetched(UIImage)
    }
    
    func clearImagesStorage() {
        for (_, value) in images {
            switch value {
            case .inProgress(let task):
                task.cancel()
            default:
                continue
            }
        }
        images = [:]
    }
    
    func fetch(withImageID imageID: String) async throws -> UIImage {
        let endpoint = "/t_cover_big/\(imageID).jpg"
        let url = baseURL.appendingPathComponent(endpoint)
        return try await fetch(url)
    }
    
    func fetch(_ url: URL) async throws -> UIImage {
        let cacheKey = NSString(string: url.absoluteString)
        if let status = images[url] {
            switch status {
            case .fetched(let image):
                return image
            case .inProgress(let task):
                return try await task.value
            }
        }
        
        if let image = self.cachedImage(for: cacheKey) {
            images[url] = .fetched(image)
            return image
        }
        
        let task: Task<UIImage, Error> = Task {
            let (imageData, _) = try await URLSession.shared.data(from: url)
            let image = UIImage(data: imageData)!
            self.cacheImage(image, for: cacheKey)
            return image
        }
        
        images[url] = .inProgress(task)
        let image = try await task.value
        images[url] = .fetched(image)
        
        return image
    }
    
    private func cachedImage(for cacheKey: NSString) -> UIImage? {
        return imageCache.object(forKey: cacheKey)
    }
    
    private func cacheImage(_ image: UIImage, for cacheKey: NSString) {
        imageCache.setObject(image, forKey: cacheKey)
    }
        
//    private func imageFromFileSystem(for urlRequest: URLRequest) throws -> UIImage? {
//        guard let url = filename(for: urlRequest) else {
//            assertionFailure("Unable to generate a local path for \(urlRequest)")
//            return nil
//        }
//
//        let data = try Data(contentsOf: url)
//        return UIImage(data: data)
//    }
//
//    private func filename(for urlRequest: URLRequest) -> URL? {
//        guard let fileName = urlRequest.url?.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
//              let applicationSupport = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
//            return nil
//        }
//        return applicationSupport.appendingPathComponent(fileName)
//    }
//
//    private func persistImage(_ image: UIImage, for urlRequest: URLRequest) throws {
//        guard let url = filename(for: urlRequest),
//              let data = image.jpegData(compressionQuality: 0.8) else {
//            assertionFailure("Unable to generate a local path for \(urlRequest)")
//            return
//        }
//
//        try data.write(to: url)
//    }
}

final class PreviewImageLoader: ImageLoadable {
    func fetch(withImageID imageID: String) async throws -> UIImage {
        UIImage(named: "test")!

    }
    
    func fetch(_ url: URL) async throws -> UIImage {
        UIImage(named: "test")!

    }
    
    func clearImagesStorage() async {
        
    }
    
    
}
