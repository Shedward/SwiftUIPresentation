//
//  LifecycleLine.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 03.11.2024.
//

import SwiftUI

struct LifecycleView<Content: View>: View {

    @Environment(\.space)
    var space: Space

    private let content: () -> Content

    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }


    var body: some View {
        Grid(horizontalSpacing: Space.min.value, verticalSpacing: Space.min.value) {
            content()
        }
        .framed()
        .space(maxSpace: .s2)
    }
}

#Preview {
    LifecycleView {
        LifecycleLine(caption: "Test", color: .red) {
            Text("Hello")
            Text("Ano")
        }

        LifecycleLine(caption: "Another", color: .blue) {
            Text("Hello sdf asdf as")
            Text("Hello")
        }
    }
}
