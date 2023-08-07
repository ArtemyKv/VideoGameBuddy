//
//  ListGameRow.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 03.08.2023.
//

import SwiftUI

struct ListGameRow: View {
    let rowViewModel: RowViewModel
    
    init(rowViewModel: RowViewModel) {
        self.rowViewModel = rowViewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .top) {
                //            rowViewModel.image
                Image("testImage")
                //                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width * 0.33)
                VStack(alignment: .leading) {
                    Text(rowViewModel.game.name)
                        .bold()
                        .font(.title3)
                    Text(rowViewModel.releaseDate)
                    Text(rowViewModel.platform)
                }
            }
        }
        
    }
}

struct GameRow_Previews: PreviewProvider {
    static let game = Game.preview
    static let rowViewModel = RowViewModel(game: game)
    
    static var previews: some View {
        ListGameRow(rowViewModel: rowViewModel)
            .previewLayout(.fixed(width: 400, height: 150))
    }
}
