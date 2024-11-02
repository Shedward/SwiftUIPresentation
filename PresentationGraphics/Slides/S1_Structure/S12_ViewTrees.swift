//
//  S11_ViewTrees.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//


import SwiftUI

struct S12_ViewTrees: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - Большинство настроек у нас описывается модификаторами
            - Модификатор это такой же лист в дереве вьюх
            """
        )
        e01("- Модификатор заворачивает контент")
        e02("- Двигая модификатор модификатор мы меняем область его действия")
    }

    var body: some View {
        TitleSubtitleLayout(
            title: "View Trees",
            subtitle: "Модификаторы заворачивают контент"
        ) {
            switch episode {
            case e00:
                e00_modifiersView
            case e01:
                e01_modifierMovedUp
            case e02:
                e02_modifiersMovesUp
            default:
                EmptyView()
            }
        }
    }

    var e00_modifiersView: some View {
        Panels {
            Panel.code {
                """
                HStack {
                    Image(systemName: "house")
                    Text("Hello")
                        .padding()
                }
                """.color()

                ".background(Color.yellow)".highlight()
            }

            Panel.viewTree {
                Tree(".background", highlight: Theme.Color.highlight) {
                    Tree("HStack", color: Theme.Color.darkHighlight) {
                        Tree("Image", color: Theme.Color.darkHighlight)
                        Tree(".padding", color: Theme.Color.darkHighlight) {
                            Tree("Text", color: Theme.Color.darkHighlight)
                        }
                    }
                    Tree("Color")
                }
            }

            Panel.preview {
                HStack {
                    Image(systemName: "house")
                    Text("Hello")
                        .padding()
                }
                .background(Color.yellow)
            }
        }
    }

    var e01_modifierMovedUp: some View {
        Panels {
            Panel.code {
                "HStack {"
                "    Image(systemName: \"house\")"
                "    Text(\"Hello\")".color()
                "        .padding()".color()
                "        .background(Color.yellow)".highlight()
                "}"
            }

            Panel.viewTree {
                Tree("HStack") {
                    Tree("Image")
                    Tree(".background", highlight: Theme.Color.highlight) {
                        Tree(".padding", color: Theme.Color.darkHighlight) {
                            Tree("Text", color: Theme.Color.darkHighlight)
                        }
                        Tree("Color")
                    }
                }
            }

            Panel.preview {
                HStack {
                    Image(systemName: "house")
                    Text("Hello")
                        .padding()
                        .background(Color.yellow)
                }
            }
        }
    }

    var e02_modifiersMovesUp: some View {
        Panels {
            Panel.code {
                "HStack {"
                "    Image(systemName: \"house\")"
                "    Text(\"Hello\")".color()
                "        .background(Color.yellow)".highlight()
                "        .padding()"
                "}"
            }

            Panel.viewTree {
                Tree("HStack") {
                    Tree("Image")
                    Tree(".padding") {
                        Tree(".background", highlight: Theme.Color.highlight) {
                            Tree("Text", color: Theme.Color.darkHighlight)
                            Tree("Color")
                        }
                    }
                }
            }

            Panel.preview {
                HStack {
                    Image(systemName: "house")
                    Text("Hello")
                        .background(Color.yellow)
                        .padding()
                }
            }
        }
    }
}
