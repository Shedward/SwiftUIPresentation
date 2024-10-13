//
//  Panels.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 09.10.2024.
//

import SwiftUI

struct Panel: Identifiable {
    var id: String { title }

    let title: String
    let content: AnyView

    init<Content: View>(_ title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = AnyView(content())
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
                        .framed(fill: Theme.Color.backgroundSecondary)
                }
            }
        }
    }
}

#Preview {
    Panels {
        Panel("Code") {
            CodeView("""
                VStack {
                    Text("Hello")
                    Text("World")
                        .fixedSize()
                        .padding()
                }
                """)
        }
        Panel("ViewTree") {
            TreeView(
                tree: Tree("VStack") {
                    Tree("helloText", title: "Text")
                    Tree(".padding") {
                        Tree(".fixedSize") {
                            Tree("worldText", title: "Text")
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
