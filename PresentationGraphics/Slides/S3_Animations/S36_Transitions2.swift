//
//  S34_ImplicitExplicit.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 09.11.2024.
//

import SwiftUI

struct S36_Transitions2: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - Transition срабатывает когда элемент добавляется или убирается
            - И она может быть ассиметричной
            - Обратите кстати внимание на то что если переключить обратно достаточно бысто
            - То будет происходить не анимация удаления а та же анимация наоборот
            - Это потому что все анимации в SwiftUI отменяемые. 
            - И если вернуть состояние в изначальное до того как анимация завершится
            - Она будет отменена и отреверсирована в изначальное состояние
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "Transition") {
            Panels {
                Panel.code {
                    """
                    .transition(
                        .asymmetric(insertion: .slide, removal: .scale)
                    )
                    """
                }
                Panel.viewTree("От") {
                    Tree("VStack") {
                        Tree("Button")
                        Tree("Optional")
                            .caption("none")
                    }
                }

                Panel.viewTree("До") {
                    Tree("VStack") {
                        Tree("Button")
                        Tree("Optional") {
                            Tree(".transition") {
                                Tree(".frame") {
                                    Tree("Rectangle")
                                }
                            }
                        }
                        .caption("some")
                    }
                }
                Panel.preview {
                    TransitionExample(transition: AsymmetricTransition(insertion: .slide, removal: .scale))
                }
            }
        }
    }
}
