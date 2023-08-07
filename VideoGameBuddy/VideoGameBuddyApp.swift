//
//  VideoGameBuddyApp.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 02.08.2023.
//

import SwiftUI

@main
struct VideoGameBuddyApp: App {
    let builder = MainBuilder()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(builder)
        }
    }
}
