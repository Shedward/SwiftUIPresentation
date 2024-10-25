//
//  PointsList.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 25.10.2024.
//

import SwiftUI

struct PointsList: View {
    let style: Style
    let items: [String]

    var body: some View {
        SpacedVStack(alignment: .leading) {
            ForEach(Array(items.enumerated()), id: \.element.self) { item in
                Text(description(for: item.offset, content: item.element))
                    .style(.body)
            }
        }
    }

    init(style: Style, items: [String]) {
        self.style = style
        self.items = items
    }

    init(_ style: Style = .bullet, @ArrayBuilder<String> items: () -> [String]) {
        self.init(style: style, items: items())
    }

    private func description(for index: Int, content: String) -> String {
        switch style {
            case .bullet:
                "• \(content)"
            case .enumerated:
                "\(index + 1). \(content)"
        }
    }

    enum Style {
        case bullet
        case enumerated
    }
}
