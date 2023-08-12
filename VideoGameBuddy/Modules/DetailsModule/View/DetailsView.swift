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
            VStack(alignment: .leading) {
                headerView()
                Group {
                    Spacer(minLength: 50)
                    VStack(alignment: .leading, spacing: 20) {
                        rowTitleView(title: "Genres:")
                        Text(viewModel.genres)
                        rowTitleView(title: "Platforms:")
                        Text(viewModel.platforms)
                        rowTitleView(title: "Summary:")
                        Text(viewModel.summary)
                        rowTitleView(title: "StoryLine:")
                        Text(viewModel.storyline)
                    }
                }
                .padding([.leading, .trailing])
            }
        }
        .navigationTitle("Game Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func headerView() -> some View {
        ZStack {
            Rectangle()
                .fill(Color(white: 0.2))
                .opacity(0.9)
            HStack {
                VStack(alignment: .leading) {
                    Text(viewModel.name)
                        .font(.title2)
                        .bold()
                        .lineLimit(2)
                    Text(viewModel.releaseDate)
                    RatingView(rating: viewModel.rating)
                        .frame(width: 90)
                        .offset(y: 50)
                }
                .padding()
                .foregroundColor(.white)
                Spacer()
                
                Image(uiImage: viewModel.image)
                    .resizable()
                    .scaledToFit()
                    .padding(8)
                
            }
        }
        .frame(height: 200)
    }
    
    private func rowTitleView(title: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .foregroundColor(Color(white: 0.2))
            Divider()
                .frame(width: 200, height: 2)
                .overlay(Color.blue)
                .offset(y: -10)
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static let builder = MainBuilder()
    static let game = Game.preview
    
    static var previews: some View {
        NavigationView {
            DetailsView(viewModel: builder.detailsViewModel(game: game))
        }
    }
}
