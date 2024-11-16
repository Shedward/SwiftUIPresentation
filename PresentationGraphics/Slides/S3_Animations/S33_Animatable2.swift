//
//  S33_Animatable.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 09.11.2024.
//

import SwiftUI

struct S33_Animatable2: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - Теперь посмотрим на примере
            - Возьмем вьюху с несколькими изменяемыми анимируемыми полями
            """
        )

        e01(
            """
            - В начале транзакции движок сделает снимок дерева с изначальныйми animatableData
            """
        )

        e02(
            """
            - В конце транзакции движок так же сделает снимок дерева с финальными значениями
            """
        )

        e03(
            """
            - И в итоге запустит анимацию которая будет изменять значения animatableData по заданой функции
            - Обратите внимание что анимация рендерится не перерисовкой всего дерева
            - А только изменением значений активных модификаторов 
            
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "Animatable", subtitle: "На практике") {
            Panels {
                Panel.code {
                    """
                    struct AnimatableNodes: View {
                         
                        @State
                        var finished: Bool = false
                         
                        var body: some View {
                            VStack {
                                Image(systemName: "globe")
                                    .imageScale(.large)
                                    .foregroundStyle(.tint)
                                    .offset(x: finished ? 0 : 50)
                                 
                                Text("Globe")
                                    .opacity(finished ? 1 : 0)
                                 
                                Button("Animate") {
                                    withAnimation {
                                        finished = true
                                    }
                                }
                            }
                        }
                    }
                    """
                }

                Panel.renderTree("До") {
                    Tree("VStack") {
                        Tree("Offset") {
                            Tree("ForegroundStyle") {
                                Tree("ImageScale") {
                                    Tree("Image")
                                }
                            }
                        }
                        .body {
                            showIf(episode, after: e01) {
                                AnimatingLabel(name: "offset.x", value: "50.0")
                                    .annotatable("fromOffset")
                            }
                        }

                        Tree("Opacity") {
                            Tree("Text")
                        }
                        .body {
                            showIf(episode, after: e01) {
                                AnimatingLabel(name: "opacity", value: "0.0")
                                    .annotatable("fromOpacity")
                            }
                        }

                        Tree("Button")
                    }
                }

                Panel.renderTree("После") {
                    Tree("VStack") {
                        Tree("Offset") {
                            Tree("ForegroundStyle") {
                                Tree("ImageScale") {
                                    Tree("Image")
                                }
                            }
                        }
                        .body {
                            AnimatingLabel(name: "offset.x", value: "0.0")
                                .annotatable("toOffset")
                        }

                        Tree("Opacity") {
                            Tree("Text")
                        }
                        .body {
                            AnimatingLabel(name: "opacity", value: "1.0")
                                .annotatable("toOpacity")
                        }

                        Tree("Button")
                    }
                }
                .showIf(episode, after: e02)
            }
        }
        .annotate {
            showIf(episode, at: e03) {
                LineAnnotation(from: "fromOpacity", to: "toOpacity")
                    .animationKind()
                LineAnnotation(from: "fromOffset", to: "toOffset")
                    .animationKind()
            }
        }
    }
}
