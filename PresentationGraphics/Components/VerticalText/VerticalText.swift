//
//  VerticalText.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 03.11.2024.
//

import SwiftUI

struct VerticalText: View {
    let text: String

    @State
    var textSize: CGSize = .zero

    init(_ text: String) {
        self.text = text
        self.textSize = textSize
    }

    var body: some View {
        ZStack {
            Text(text)
                .fixedSize()
                .rotationEffect(Angle(degrees: -90))
                .onResize { textSize = $0 }
        }
        .frame(width: textSize.height, height: textSize.width)
    }
}
