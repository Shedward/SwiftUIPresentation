//
//  SlideView.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//

import SwiftUI

struct TitleSubtitleLayout<Content: View>: View {
    let title: String
    let subtitle: String?
    let content: () -> Content

    init(
        title: String,
        subtitle: String? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.content = content
    }

    var body: some View {
        SpacedVStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .style(.title)
                if let subtitle {
                    Text(subtitle)
                        .style(.subtitle)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()
            content()
            Spacer()
        }
        .spaced()
    }
}

#Preview {
    TitleSubtitleLayout(
        title: "Определение RenderTree",
        subtitle: "Что это такое?"
    ) {
        Panels {
            Panel("Код") {
                Text("Панель 1")
            }
            Panel("Панель 2") {
                Text("Панель 2")
            }
        }
    }
}
