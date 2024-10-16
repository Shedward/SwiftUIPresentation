//
//  S11_View.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 17.10.2024.
//

import SwiftUI

struct S11_View: View, Slide {

    @Environment(\.episode)
    var episode: String

    var episodes: [Episode] {
        "e01-показываем-view-tree"
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
                }.showIf(episode, after: "e01-показываем-view-tree")

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