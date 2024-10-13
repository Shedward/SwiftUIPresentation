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

    init(title: String, subtitle: String? = nil, @ArrayBuilder<String> items: () -> [String]) {
        self.title = title
        self.subtitle = subtitle
        self.items = items()
    }

    var body: some View {
        TitleSubtitleLayout(title: title, subtitle: subtitle) {
            SpacedVStack(alignment: .leading) {
                ForEach(items, id: \.self) { item in
                    Text("• \(item)")
                        .style(.body)
                }
            }
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
