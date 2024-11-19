//
//  S30_Animations.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

struct S49_MatchedGeometryEffect2: View, Slide {

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
                    struct MatchedGeometryTransitionExample: View {
                         
                        @Namespace
                        var namespace
                         
                        @State
                        var isCircle: Bool = true
                         
                        var body: some View {
                            VStack {
                                if isCircle {
                                    Text("Hello")
                                        .frame(maxWidth: .infinity)
                                        .transition(.opacity)
                                        .matchedGeometryEffect(id: "text", in: namespace)
                                    Circle()
                                        .frame(width: 50, height: 50)
                                        .transition(.blurReplace)
                                        .matchedGeometryEffect(id: "figure", in: namespace)
                                } else {
                                    Rectangle()
                                        .frame(width: 50, height: 50)
                                        .transition(.blurReplace)
                                        .matchedGeometryEffect(id: "figure", in: namespace)
                                    Text("Bye")
                                        .frame(maxWidth: .infinity)
                                        .transition(.opacity)
                                        .matchedGeometryEffect(id: "text", in: namespace)
                                }
                                 
                                Button("Toggle") {
                                    withAnimation {
                                        isCircle.toggle()
                                    }
                                }
                            }
                            .frame(width: 200)
                            .padding()
                        }
                    }
                    """
                }

                Panel.preview {
                    MatchedGeometryTransitionExample()
                }
            }
        }
    }
}
