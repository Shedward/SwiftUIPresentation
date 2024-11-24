//
//  LifecycleLine.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 03.11.2024.
//

import SwiftUI

struct LifecycleLine<Content: View>: View {

    @Environment(\.space)
    var space: Space

    let caption: String
    let color: Color
    let content: () -> Content

    init(caption: String, color: Color, @ViewBuilder content: @escaping () -> Content) {
        self.caption = caption
        self.color = color
        self.content = content
    }

    public var body: some View {
        GridRow {
            VerticalText(caption)
                .style(.caption)
                .padding(.vertical, Space.min.value)
                .fixedSize()
                .gridCellAnchor(.trailing)

            Rectangle()
                .fill(color)
                .frame(width: 0.5 * Space.min.value)
                .gridCellUnsizedAxes(.vertical)

            content()
                .fixedSize()
                .gridCellAnchor(.leading)
        }
    }

    static func appear(@ViewBuilder content: @escaping () -> Content) -> Self {
        LifecycleLine(caption: "appear", color: Theme.Color.lifecycleAppear, content: content)
    }

    static func disappear(@ViewBuilder content: @escaping () -> Content) -> Self {
        LifecycleLine(caption: "disappear", color: Theme.Color.lifecycleDisappear, content: content)
    }

    static func change(@ViewBuilder content: @escaping () -> Content) -> Self {
        LifecycleLine(caption: "change", color: Theme.Color.lifecycleChange, content: content)
    }

    static func instance(@ViewBuilder content: @escaping () -> Content) -> Self {
        LifecycleLine(caption: "instance", color: Theme.Color.contentSecondary, content: content)
    }
}
