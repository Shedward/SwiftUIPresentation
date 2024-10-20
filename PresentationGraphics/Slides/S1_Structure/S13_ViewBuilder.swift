//
//  S13_ViewBuilder.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 17.10.2024.
//

import SwiftUI

struct S13_ViewBuilder: View, Slide {

    @Environment(\.episode)
    var episode: String

    var episodes: [Episode] {
        "e01-определение-vstack"
    }

    var body: some View {
        TitleSubtitleLayout(title: "@ViewBuilder") {
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
                }.showIf(episode, at: "e01-определение-vstack")

                Panel.code {
                    """
                    VStack {
                        Image(systemName: "house")
                        Text("Hello")
                        Image(systemName: "hand.wave")
                    """
                        .highlight(
                            episode >= "e01-определение-vstack"
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
