//
//  S30_Animations.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

struct S49_MatchedGeometryEffect: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - И последняя advance механика лайаута - MatchedGeometryEffect
            - Она позволяет буквально приклеить две вьюхи друг к другу по положению и размеру
            - Вне зависимости от того где в иерархии они находятся
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "MatchedGeometryEffect") {
            Panels {
                Panel.code(font: Theme.Font.codeExtraSmall) {
                    """
                    struct MatchedGeometryExample: View {
                         
                        @Namespace
                        var namespace
                         
                        @State
                        var matchedId: Int = 0
                         
                        var body: some View {
                            VStack {
                                Grid(horizontalSpacing: 16, verticalSpacing: 16) {
                                    GridRow {
                                        Text("Some text")
                                            .matchedGeometryEffect(id: 0, in: namespace)
                                        Circle()
                                            .matchedGeometryEffect(id: 1, in: namespace)
                                    }
                                    GridRow {
                                        Image(systemName: "gamecontroller")
                                            .matchedGeometryEffect(id: 2, in: namespace)
                                        Text("Another text")
                                            .matchedGeometryEffect(id: 3, in: namespace)
                                    }
                                }
                                .overlay {
                                    Rectangle()
                                        .matchedGeometryEffect(id: matchedId % 5, in: namespace, isSource: false)
                                        .animation(.default, value: matchedId)
                                }
                                .padding()
                                 
                                Button("Next") {
                                    matchedId += 1
                                }
                            }
                        }
                    }
                    """
                }

                Panel.preview {
                    MatchedGeometryExample()
                }
            }
        }
    }
}
