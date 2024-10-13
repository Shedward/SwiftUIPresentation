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

    let style: Style

    init(title: String, subtitle: String? = nil, style: Style = .bullet, @ArrayBuilder<String> items: () -> [String]) {
        self.title = title
        self.subtitle = subtitle
        self.style = style
        self.items = items()
    }

    var body: some View {
        TitleSubtitleLayout(title: title, subtitle: subtitle) {
            SpacedVStack(alignment: .leading) {
                ForEach(Array(items.enumerated()), id: \.element.self) { item in
                    Text(description(for: item.offset, content: item.element))
                        .style(.body)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }

    private func description(for index: Int, content: String) -> String {
        switch style {
            case .bullet:
                "• \(content)"
            case .enumerated:
                "\(index + 1). \(content)"
        }
    }
}

extension ListLayout {
    enum Style {
        case bullet
        case enumerated
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
