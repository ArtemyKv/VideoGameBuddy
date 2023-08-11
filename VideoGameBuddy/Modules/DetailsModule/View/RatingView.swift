//
//  RatingView.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 11.08.2023.
//

import SwiftUI

struct RatingView: View {
    var rating: Int
    @State private var color: Color = .green
    @State private var ratingString: String = "Awesome"
    
    var body: some View {
        GeometryReader { g in
            ZStack(alignment: .center) {
                Circle()
                    .stroke(Color(white: 0.9), lineWidth: sizeScale(withGeometry: g, divider: 15))
                Circle()
                    .trim(from: 0, to: CGFloat(rating) / 100)
                    .scale(x: -1, y: -1, anchor: .center)
                    .rotation(.degrees(90))
                    .stroke(color, lineWidth: (g.size.width < g.size.height) ? g.size.width / 15 : g.size.height / 15)
                VStack {
                    Text(String(rating))
                        .bold()
                        .font(.system(size: (g.size.width < g.size.height) ? g.size.width / 2.5 : g.size.height / 2.5))
                    Text(ratingString)
                        .offset(y: -g.size.width)
                        .font(.system(size: (g.size.width < g.size.height) ? (g.size.width / 10) : g.size.height / 10))
                        .foregroundColor(color)
                }
                .foregroundColor(.black)
            }
        }
        .padding()
    }
    
    init(rating: Int) {
        self.rating = rating
        configure()
    }
    
    private func sizeScale(withGeometry geometry: GeometryProxy, divider: CGFloat) -> CGFloat {
        return (geometry.size.width < geometry.size.height) ? geometry.size.width / divider : geometry.size.height / divider
    }
    
    private func configure() {
        guard rating <= 100, rating >= 0 else { return }
        switch rating {
        case 0...9:
            ratingString = "Awful"
        case 10...19:
            ratingString = "Very Bad"
        case 20...29:
            ratingString = "Bad"
        case 30...39:
            ratingString = "Unimpressive"
        case 40...49:
            ratingString = "Average"
        case 50...59:
            ratingString = "Fair"
        case 60...69:
            ratingString = "Alright"
        case 70...79:
            ratingString = "Good"
        case 80...89:
            ratingString = "Great"
        case 90...100:
            ratingString = "Superb"
        default:
            break
            
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: 60)
    }
}
