//
//  CirclesOverlay.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 17.11.2024.
//


import SwiftUI

public struct SizeOverlay: View {
    public var body: some View {
        GeometryReader { proxy in
            Text("\(proxy.size)")
                .style(.codeExtraSmall)
                .background(Theme.Color.backgroundSecondary)
            Rectangle()
                .stroke(style: .init(lineWidth: 1, dash: [2, 2]))
        }
    }
}

#Preview {
    VStack {
        Image(systemName: "person.crop.circle")
        Text("Something something text")
        Text("Another text")
    }
    .padding()
    .overlay {
        SizeOverlay()
    }
    .padding()
}
