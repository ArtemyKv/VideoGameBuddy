//
//  DetailsView.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 02.08.2023.
//

import SwiftUI

struct DetailsView: View {
    @StateObject var viewModel: DetailsViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                Group {
                    Image(uiImage: viewModel.image)
                    Text(viewModel.rating)
                    Divider()
                    Text(viewModel.name)
                    Divider()
                    Text(viewModel.releaseDate)
                    Divider()
                    Text(viewModel.genres)
                    Divider()
                }
                Group {
                    Text(viewModel.platforms)
                    Divider()
                    Text(viewModel.summary)
                    Divider()
                    Text(viewModel.storyline)
                }
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static let builder = MainBuilder()
    static let game = Game.preview
    
    static var previews: some View {
        DetailsView(viewModel: builder.detailsViewModel(game: game))
    }
}
