//
//  ContentView.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 02.08.2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var builder: MainBuilder
    
    var body: some View {
        NavigationView {
            SearchView(viewModel: builder.searchViewModel())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let builder = MainBuilder()
    
    static var previews: some View {
        ContentView()
            .environmentObject(builder)
    }
}
