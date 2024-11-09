//
//  AnimationLabel.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 09.11.2024.
//

import SwiftUI

struct AnimatingLabel: View {
    let name: String
    let value: String

    var body: some View {
        VStack {
            Label {
                Text("\(name)")
                    .fixedSize()
            } icon: {
                Image(systemName: "video")
            }
            Text("\(value)")
        }
        .style(.caption.color(Theme.Color.tintSecondary))
    }
}
