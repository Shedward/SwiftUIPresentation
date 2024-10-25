//
//  DiffView.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 25.10.2024.
//

import SwiftUI

struct DiffView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        SpacedVStack(alignment: .leading) {
            content
        }
        .framed(fill: Theme.Color.backgroundSecondary)
        .space(maxSpace: .s3)
    }

}

struct DiffRow: View {

    let kind: DiffKind
    let path: [String]
    var content: String?

    @Environment(\.space)
    var space: Space

    var body: some View {
        HStack(alignment: .lastTextBaseline, spacing: 2 * space.innerValue()) {
            kind.icon
                .foregroundStyle(Theme.Color.backgroundSecondary)
                .padding(space.innerValue(2))
                .frame(
                    width: 4 * space.innerValue(),
                    height: 4 * space.innerValue()
                )
                .background {
                    RoundedRectangle(cornerRadius: space.innerValue())
                        .fill(kind.color)
                }

            Text(path.joined(separator: " :: "))
            if let content {
                Text(content)
                    .style(.caption)
            }
        }
        .style(.body)
    }
}

enum DiffKind {
    case added
    case removed
    case changed

    var icon: Image {
        switch self {
        case .added:
            Image(systemName: "plus")
        case .removed:
            Image(systemName: "minus")
        case .changed:
            Image(systemName: "arrow.triangle.2.circlepath")
        }
    }

    var color: Color {
        switch self {
        case .added:
            Color.green
        case .removed:
            Color.red
        case .changed:
            Color.yellow
        }
    }
}

#Preview {
    DiffView {
        DiffRow(kind: .added, path: ["HStack", "Text"])
        DiffRow(kind: .added, path: ["HStack", "Optional", "Image"])
        DiffRow(kind: .changed, path: ["HStack", "Text"], content: "Старый текст → Новый текст")
        DiffRow(kind: .removed, path: ["HStack", "Text"])
    }
    .padding()
}

