//
//  S11_ViewTrees.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//


import SwiftUI

struct S12_ViewTrees: View, Slide {

    @Environment(\.step)
    var step: String


    var body: some View {
        TitleSubtitleLayout(
            title: "View Trees",
            subtitle: "Модификаторы заворачивают контент"
        ) {
            switch step {
            case "e01":
                e01
            case "e02":
                e02
            default:
                e00
            }
        }
    }

    var e00: some View {
        Panels {
            Panel("Код") {
                CodeView {
                    """
                    HStack {
                        Image(systemName: "house")
                        Text("Hello")
                            .padding()
                    }
                    """.color()

                    ".background(Color.yellow)".highlight()
                }
            }
            Panel("View Tree") {
                TreeView(tree: Tree(".background", highlight: Theme.Color.highlight) {
                    Tree("HStack", color: Theme.Color.darkHighlight) {
                        Tree("Image", color: Theme.Color.darkHighlight)
                        Tree(".padding", color: Theme.Color.darkHighlight) {
                            Tree("Text", color: Theme.Color.darkHighlight)
                        }
                    }
                    Tree("Color")
                })
            }
            Panel("Preview") {
                HStack {
                    Image(systemName: "house")
                    Text("Hello")
                        .padding()
                }
                .background(Color.yellow)
                .bordered()
            }
        }
    }

    var e01: some View {
        Panels {
            Panel("Код") {
                CodeView {
                    "HStack {"
                    "    Image(systemName: \"house\")"
                    "    Text(\"Hello\")".color()
                    "        .padding()".color()
                    "        .background(Color.yellow)".highlight()
                    "}"
                }
            }
            Panel("View Tree") {
                TreeView(tree: Tree("HStack") {
                        Tree("Image")
                        Tree(".background", highlight: Theme.Color.highlight) {
                            Tree(".padding", color: Theme.Color.darkHighlight) {
                                Tree("Text", color: Theme.Color.darkHighlight)
                            }
                            Tree("Color")
                        }
                    }
                )
            }
            Panel("Preview") {
                HStack {
                    Image(systemName: "house")
                    Text("Hello")
                        .padding()
                        .background(Color.yellow)
                }
                .bordered()
            }
        }
    }

    var e02: some View {
        Panels {
            Panel("Код") {
                CodeView {
                    "HStack {"
                    "    Image(systemName: \"house\")"
                    "    Text(\"Hello\")".color()
                    "        .background(Color.yellow)".highlight()
                    "        .padding()"
                    "}"
                }
            }
            Panel("View Tree") {
                TreeView(tree: Tree("HStack") {
                        Tree("Image")
                        Tree(".padding") {
                            Tree(".background", highlight: Theme.Color.highlight) {
                                Tree("Text", color: Theme.Color.darkHighlight)
                                Tree("Color")
                            }
                        }
                    }
                )
            }
            Panel("Preview") {
                HStack {
                    Image(systemName: "house")
                    Text("Hello")
                        .background(Color.yellow)
                        .padding()
                }
                .bordered()
            }
        }
    }

    var steps: [Step] {
        "e01"
        "e02"
    }
}
