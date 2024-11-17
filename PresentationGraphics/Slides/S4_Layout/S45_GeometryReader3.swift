//
//  S30_Animations.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

struct S45_GeometryReader3: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - Другой частый кейс использования 
            - Нарисовать что-то поверх вьюхи зависящее от размера
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "GeometryReader", subtitle: "Нарисовать что-то поверх") {
            Panels {
                Panel.code {
                    """
                    public struct SizeOverlay: View {
                        public var body: some View {
                            GeometryReader { proxy in
                                Text("\\(proxy.size)")
                                    .style(.codeExtraSmall)
                                    .background(Theme.Color.backgroundSecondary)
                                Rectangle()
                                    .stroke(style: .init(lineWidth: 1, dash: [2, 2]))
                            }
                        }
                    }

                    #Preview {
                        VStack {
                            Image(systemName: "person.crop.circle")
                            Text("Something something text")
                            Text("Another text")
                        }
                        .padding()
                        .overlay {
                            SizeOverlay()
                        }
                        .padding()
                    }
                    """
                }

                Panel.preview {
                    VStack {
                        Image(systemName: "person.crop.circle")
                        Text("Something something text")
                        Text("Another text")
                    }
                    .padding()
                    .overlay {
                        SizeOverlay()
                    }
                    .padding()
                }
            }
        }
    }
}
