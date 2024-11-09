//
//  S33_Animatable.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 09.11.2024.
//

import SwiftUI

struct S33_Animatable: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - Теперь немного подробнее про то ЧТО конкретно мы анимируем
            - Мы анимием не State и не все дерево вьюх, мы анимируем только те ноды которые возможно анимировать
            - В SwiftUI такие ноды помечаются протоколом Animatable  
            """
        )

        e01(
            """
            - На практике обычно Animatable обладают модификаторы
            - Для примера кастомный модификатор прозрачности может выглядеть примерно так
            - Обратите внимание что протокол требует чтобы animatableData была get/set и VectorArithmetic
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "Animatable") {
            Panels {
                Panel.code("Animatable") {
                    """
                    protocol Animatable {
                        associatedtype AnimatableData: VectorArithmetic 
                    
                        var animatableData: AnimatableData { get set }
                    }
                    """
                }

                Panel.code("Реализация") {
                    """
                    struct MyOpacity: ViewModifier, Animatable {
                         
                    """
                    "    var animatableData: Double"
                        .highlight()
                    """
                         
                        init(_ opacity: Double) {
                            animatableData = opacity
                        }
                         
                        func body(content: Content) -> some View {
                            content.opacity(animatableData)
                        }
                    }
                    """
                }
                .showIf(episode, at: e01)
            }
        }
    }
}
