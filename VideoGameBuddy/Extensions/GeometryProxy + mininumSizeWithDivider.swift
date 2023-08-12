//
//  GeometryProxy + mininumSizeWithDivider.swift
//  VideoGameBuddy
//
//  Created by Artem Kvashnin on 11.08.2023.
//

import Foundation
import SwiftUI

extension GeometryProxy {
    func minimumSizeApplyingDivider(_ divider: CGFloat) -> CGFloat {
        return (self.size.width < self.size.height) ? self.size.width / divider : self.size.height / divider
    }
}
