//
//  Box.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 13.11.2024.
//

import SwiftUI

struct Box: View {
    let width: CGFloat
    let height: CGFloat

    init(_ size: CGFloat) {
        self.init(width: size, height: size)
    }

    init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }

    init(size: CGSize) {
        self.init(width: size.width, height: size.height)
    }

    var body: some View {
        Color.clear
            .frame(width: width, height: height)
    }
}
