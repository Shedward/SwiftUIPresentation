//
//  Stacks.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//

import SwiftUI

struct SpacedHStack<Content: View>: View {

    @Environment(\.space)
    var space: Space

    let alignment: VerticalAlignment
    let step: Int
    let content: () -> Content

    init(alignment: VerticalAlignment = .center, step: Int = 1, @ViewBuilder content: @escaping () -> Content) {
        self.alignment = alignment
        self.step = step
        self.content = content
    }

    var body: some View {
        HStack(alignment: alignment, spacing: space.innerValue(step)) {
            content()
        }
        .reduceSpacing()
    }
}

struct SpacedVStack<Content: View>: View {

    @Environment(\.space)
    var space: Space

    let alignment: HorizontalAlignment
    let step: Int
    let content: () -> Content

    init(alignment: HorizontalAlignment = .center, step: Int = 1, @ViewBuilder content: @escaping () -> Content) {
        self.alignment = alignment
        self.step = step
        self.content = content
    }

    var body: some View {
        VStack(alignment: alignment, spacing: space.innerValue(step)) {
            content()
        }
        .reduceSpacing()
    }
}

#Preview {
    SpacedVStack {
        Rectangle()
        SpacedHStack {
            SpacedVStack {
                Circle()
                Circle()
                Rectangle()
            }
            Rectangle()
            SpacedVStack {
                Rectangle()
                SpacedHStack {
                    Rectangle()
                    Circle()
                    Circle()
                    Circle()
                }
                Rectangle()
            }
        }
    }
    .framed()
}
