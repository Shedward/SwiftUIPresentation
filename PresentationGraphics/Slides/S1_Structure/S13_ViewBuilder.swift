//
//  S13_ViewBuilder.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 17.10.2024.
//

import SwiftUI

struct S13_ViewBuilder: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00 {
            "Тела вьюх это @ViewBuilder"
            "Внешне словно VStack принимает список"
        }
        e01 {
            "Но если посмотреть на определение VStack он принимает функцию возвращающую вьюху"
            "Причем ровно одну вьюху"
        }
    }

    var body: some View {
        TitleSubtitleLayout(
            title: "@ViewBuilder",
            subtitle: "Самая база описания вьюх"
        ) {
            Panels {
                Panel.code("VStack.swift") {
                    """
                    public struct VStack<Content> : View where Content : View {
                        init(
                            alignment: HorizontalAlignment, 
                            spacing: CGFloat?, 
                    """
                    """
                            @ViewBuilder content: () -> Content
                    """.highlight()

                    """
                        ) {
                            ...
                        }
                    }
                    """
                }.showIf(episode, at: e01)

                Panel.code {
                    """
                    VStack {
                    """

                    """
                        Image(systemName: "house")
                        Text("Hello")
                        Image(systemName: "hand.wave")
                    """
                        .highlight(
                            episode >= e01
                            ? Theme.Color.highlight
                            : nil
                        )

                    """
                    }
                    """
                }

                Panel.preview {
                    VStack {
                        Image(systemName: "house")
                        Text("Hello")
                        Image(systemName: "hand.wave")
                    }
                }
            }
        }
    }
}

#Preview {
    S13_ViewBuilder()
}
