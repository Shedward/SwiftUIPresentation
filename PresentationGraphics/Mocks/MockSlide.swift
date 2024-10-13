//
//  MockSlide.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//

import SwiftUI

struct MockSlide: View, Slide {
    let id: String

    init(id: String = UUID().uuidString) {
        self.id = id
    }

    var body: some View {
        SpacedVStack {
            Image(systemName: "videoprojector")
            Text(id)
        }
            .style(.debug.color(Theme.Color.backgroundPrimary))
            .framed(fill: Theme.Color.debug, strokeWidth: 2)
            .reduceSpacing(by: 3)
    }
}

#Preview {
    MockSlide(id: "00_MockSlide")
}
