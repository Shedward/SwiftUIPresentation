//
//  ListLayout.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//

import SwiftUI

struct ListLayout: View {
    let title: String
    let subtitle: String?
    let items: [String]

    let style: PointsList.Style

    init(title: String, subtitle: String? = nil, style: PointsList.Style = .bullet, @ArrayBuilder<String> items: () -> [String]) {
        self.title = title
        self.subtitle = subtitle
        self.style = style
        self.items = items()
    }

    var body: some View {
        TitleSubtitleLayout(title: title, subtitle: subtitle) {
            PointsList(style: style, items: items)
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    ListLayout(title: "Утром") {
        "Пресс качат"
        "Бегит"
        "Турник"
        "Анжуманя"
    }
}
