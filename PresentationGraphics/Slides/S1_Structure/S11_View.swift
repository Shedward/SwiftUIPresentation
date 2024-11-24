//
//  S11_View.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 17.10.2024.
//

import SwiftUI

struct S11_View: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00 {
            "Верстаем кодом"
        }
        e01 {
            "Код описывает дерево вьюх"
        }
    }

    var body: some View {
        TitleSubtitleLayout(
            title: "View Trees",
            subtitle: "Вьюхи это деревья"
        ) {
            Panels {
                Panel.code {
                    """
                    HStack {
                        Image(systemName: "house")
                        Text("Hello")
                            .padding()
                    }
                    """
                }

                Panel.viewTree {
                    Tree("HStack") {
                        Tree("Image")
                        Tree(".padding") {
                            Tree("Text")
                        }
                    }
                }.showIf(episode, at: e01)

                Panel.preview {
                    HStack {
                        Image(systemName: "house")
                        Text("Hello")
                            .padding()
                    }
                }
            }
        }
    }
}
