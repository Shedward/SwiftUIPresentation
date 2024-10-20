//
//  S11_ViewTrees.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//


import SwiftUI

struct S12_ViewTrees: View, Slide {

    @Environment(\.episode)
    var episode: String

    var episodes: [Episode] {
        "e01-двигаем-модификатор-выше"
        "e02-еще-выше"
    }

    var notes: String? {
        """
        e00 - Большинство настроек у нас описывается модификаторами
            - Модификатор это такой же лист в дереве вьюх
        e01 - Модификаторы заворачивают контент в себя контент на который он навешан
        e02 - Двигая модификатор по дереву - мы уменьшаем или увеличиваем скоуп влияния
        """
    }

    var body: some View {
        TitleSubtitleLayout(
            title: "View Trees",
            subtitle: "Модификаторы заворачивают контент"
        ) {
            switch episode {
            case "e00":
                e00
            case "e01-двигаем-модификатор-выше":
                e01
            case "e02-еще-выше":
                e02
            default:
                EmptyView()
            }
        }
    }

    var e00: some View {
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

    var e01: some View {
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

    var e02: some View {
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
