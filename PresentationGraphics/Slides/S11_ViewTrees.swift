//
//  S11_ViewTrees.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//


import SwiftUI

struct S11_ViewTrees: View, Slide {

    @Environment(\.step)
    var step: String


    var body: some View {
        TitleSubtitleLayout(
            title: "View Trees",
            subtitle: "Вьюхи это деревья"
        ) {
            Group {
                switch step {
                case "e01":
                    e01
                default:
                    e00
                }
            }
        }
    }

    var e00: some View {
        Panels {
            Panel("Код") {
                CodeView {
                    "Text(\"Hello\")"
                    "    .padding()"
                        .highlight()
                    "    .background(Color.blue)"
                }
            }
            Panel("View Tree") {
                TreeView(tree: Tree(".background") {
                    Tree(".padding", highlight: Theme.Color.highlight) {
                        Tree("Text")
                    }
                    Tree("Color")
                })
            }
            Panel("Preview") {
                Text("Hello")
                    .padding()
                    .background(Color.blue)
                    .bordered()
            }
        }
    }

    var e01: some View {
        Panels {
            Panel("Код") {
                CodeView {
                    "Text(\"Hello\")"
                    "    .background(Color.blue)"
                    "    .padding()"
                        .highlight()
                }
            }
            Panel("View Tree") {
                TreeView(tree: Tree(".padding", highlight: Theme.Color.highlight) {
                    Tree(".background") {
                        Tree("Text")
                        Tree("Color")
                    }
                })
            }
            Panel("Preview") {
                Text("Hello")
                    .background(Color.blue)
                    .padding()
                    .bordered()
            }
        }
    }

    var steps: [Step] {
        "e01"
    }
}

#Preview {
    S11_ViewTrees()
}
