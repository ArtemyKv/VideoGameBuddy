//
//  GridGameRow.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 03.08.2023.
//

import SwiftUI

struct GridGameRow: View {
    @ObservedObject var rowViewModel: RowViewModel
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(uiImage: rowViewModel.image)
                .resizable()
            LinearGradient(colors: [.black.opacity(0.5), .clear], startPoint: .bottom, endPoint: .center)
            Text(rowViewModel.releaseDate)
                .font(.body)
                .foregroundColor(.white)
                .padding(8)
        }
        .aspectRatio(contentMode: .fit)
    }
}

struct GridGameRow_Previews: PreviewProvider {
    static let game = Game.preview
    static let builder = MainBuilder()
    
    static var previews: some View {
        GridGameRow(rowViewModel: builder.rowViewModel(game: game))
    }
}
