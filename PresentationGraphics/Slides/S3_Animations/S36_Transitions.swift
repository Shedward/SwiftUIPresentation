//
//  S34_ImplicitExplicit.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 09.11.2024.
//

import SwiftUI

struct S36_Transitions: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - И так мы поговорили про анимации на изменения
            - Но у нас так же есть анимации на добавление/удаление вью из дерева - transition'ы
            """
        )

        e01(
            """
            - Объявляются они через модификатор transition
            - Выглядт это так
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "Transition") {
            Panels {
                Panel.code {
                    """
                    struct ContentView: View {
                        @State private var flag = true
                         
                        var body: some View {
                            VStack {
                                Button("Toggle") {
                                    withAnimation { flag.toggle() }
                                }
                                if flag {
                                    Rectangle()
                                        .frame(width: 100, height: 100)
                    """
                    showIf(episode, after: e01) {
                        "                    .transition(.opacity)"
                            .highlight(episode == e01)
                    }
                    """
                                }
                            }
                        }
                    }
                    """
                }

                Panel.viewTree {
                    Tree("VStack") {
                        Tree("Button")
                        Tree("Optional") {
                            if episode < e01 {
                                Tree(".frame") {
                                    Tree("Rectangle")
                                }
                            } else {
                                Tree(".transition") {
                                    Tree(".frame") {
                                        Tree("Rectangle")
                                    }
                                }
                                .highlight(episode == e01)
                            }
                        }
                    }
                }

                Panel.preview {
                    TransitionExample(transition: .opacity)
                }
            }
        }
    }
}
