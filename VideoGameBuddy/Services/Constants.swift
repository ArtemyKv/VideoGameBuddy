//
//  Constants.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 03.08.2023.
//

import Foundation

enum APIConstants {
    enum URLs {
        static let authorizationURL = URL(string: "https://id.twitch.tv/oauth2/token")!
        static let apiURL = URL(string: "https://api.igdb.com/v4")!
        static let imagesURL = URL(string: "https://images.igdb.com/igdb/image/upload")!
    }
    
    enum IDs {
        static let clientID = "7x77kdtxyaz2hgo7hjor0fd50izy5a"
        static let clientSecret = "6m751ufn9vkjjl5znmw2n8qid9onug"
    }
}
