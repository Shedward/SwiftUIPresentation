//
//  Panels.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 09.10.2024.
//

import SwiftUI

struct Panel: Identifiable, ShowIfable, Withable {
    var id: String { title }

    let title: String
    let content: AnyView
    var background: Color?

    init<Content: View>(_ title: String, background: Color? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.background = background
        self.content = AnyView(content())
    }

    func background(_ color: Color?) -> Self {
        with { $0.background = color }
    }
}

struct Panels: View {

    @Environment(\.space)
    var space: Space

    let panels: [Panel]

    init(@ArrayBuilder<Panel> _ panels: () -> [Panel]) {
        self.panels = panels()
    }

    var body: some View {
        Grid(
            alignment: .center,
            horizontalSpacing: space.value,
            verticalSpacing: space.innerValue()
        ) {
            GridRow {
                ForEach(panels) { panel in
                    Text(panel.title)
                        .style(.caption)
                }
            }
            GridRow {
                ForEach(panels) { panel in
                    panel.content
                        .frame(maxHeight: .infinity)
                        .framed(fill: panel.background ?? Theme.Color.backgroundSecondary)
                }
            }
        }
    }
}

#Preview {
    Panels {
        Panel("Code") {
            CodeView(code: Code("""
                VStack {
                    Text("Hello")
                    Text("World")
                        .fixedSize()
                        .padding()
                }
                """))
        }
        Panel("ViewTree") {
            TreeView(
                tree: Tree("VStack") {
                    Tree("Text", id: "hello-text")
                    Tree(".padding") {
                        Tree(".fixedSize") {
                            Tree("Text", id: "world-text")
                        }
                    }
                }
            )
        }
    }
    .framed()
    .space(.s1)
    .background(Theme.Color.backgroundPrimary)
}
