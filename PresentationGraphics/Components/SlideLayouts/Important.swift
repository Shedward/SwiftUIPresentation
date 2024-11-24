//
//  ImportantInfo.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 03.11.2024.
//

import SwiftUI

struct ImportantLayout: View {

    @Environment(\.space)
    var space: Space

    let text: String
    let caption: String?
    var color: Color = Theme.Color.important

    init(_ text: String, caption: String? = nil) {
        self.text = text
        self.caption = caption
    }

    init(_ text: String, @ArrayBuilder<String> _ caption: () -> [String]) {
        self.text = text
        let captionLines = caption()
        self.caption = if captionLines.count == 0 {
            nil
        } else if captionLines.count == 1 {
            captionLines[0]
        } else {
            captionLines
                .map { "- \($0)" }
                .joined(separator: "\n")
        }
    }

    public var body: some View {
        SpacedHStack(alignment: .firstTextBaseline) {
            Image(systemName: "exclamationmark")
                .foregroundStyle(color)
            SpacedVStack(alignment: .leading) {
                Text(text)
                if let caption {
                    Text(caption)
                        .style(.body)
                }
            }
        }
        .style(.important)
        .framed(
            fill: color.mix(with: .white, by: 0.7),
            stroke: color,
            strokeWidth: 2
        )
        //.space(maxSpace: .s2)
    }
}

#Preview {
    ImportantLayout("Тело View это не код") {
        "Первая причина"
        "Вторая причина"
    }
    .padding()
    .background(Theme.Color.backgroundPrimary)
}
