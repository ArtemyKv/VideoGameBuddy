//
//  RatingView.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 11.08.2023.
//

import SwiftUI

struct RatingView: View {
    var rating: Int
    var color: Color {
        configureRatingColor()
    }
    
    var ratingString: String {
        configureRatingString()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Circle()
                    .fill(Color.white)
                Group {
                    Circle()
                        .stroke(Color(white: 0.9), lineWidth: geometry.minimumSizeApplyingDivider(15))
                    Circle()
                        .trim(from: 0, to: CGFloat(rating) / 100)
                        .scale(x: -1, y: -1, anchor: .center)
                        .rotation(.degrees(90))
                        .stroke(color, lineWidth: geometry.minimumSizeApplyingDivider(15))
                    VStack {
                        Text(String(rating))
                            .bold()
                            .font(.system(size: geometry.minimumSizeApplyingDivider(2.2)))
                        Text(ratingString)
                            .offset(y: geometry.minimumSizeApplyingDivider(-10))
                            .font(.system(size: geometry.minimumSizeApplyingDivider(8)))
                            .foregroundColor(color)
                            .lineLimit(1)
                    }
                    .foregroundColor(.black)
                }
//                .padding()
            }
        }
    }
    
    init(rating: Int) {
        self.rating = rating
    }
    
    private func sizeScale(withGeometry geometry: GeometryProxy, divider: CGFloat) -> CGFloat {
        return (geometry.size.width < geometry.size.height) ? geometry.size.width / divider : geometry.size.height / divider
    }
    
    private func configureRatingString() -> String {
        guard rating <= 100, rating >= 0 else { return "" }
        var ratingString = ""
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
        return ratingString
    }
    
    private func configureRatingColor() -> Color {
        guard rating <= 100, rating >= 0 else { return Color(white:0.9) }
        var color = Color(white:0.9)
        switch rating {
        case 0...9:
            color = Color("Color 0")
        case 10...19:
            color = Color("Color 1")
        case 20...29:
            color = Color("Color 2")
        case 30...39:
            color = Color("Color 3")
        case 40...49:
            color = Color("Color 4")
        case 50...59:
            color = Color("Color 5")
        case 60...69:
            color = Color("Color 6")
        case 70...79:
            color = Color("Color 7")
        case 80...89:
            color = Color("Color 8")
        case 90...100:
            color = Color("Color 9")
        default:
            break
        }
        return color
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: 31)
    }
}
