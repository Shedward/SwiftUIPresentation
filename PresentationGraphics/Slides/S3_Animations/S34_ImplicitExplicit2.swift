//
//  S34_ImplicitExplicit.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 09.11.2024.
//

import SwiftUI

struct S34_ImplicitExplicit2: View, Slide {

    var episodes: [Episode] {
        e00(
            """
            - Или же мы можем повесить анимацию глобально
            - На любое изменение выбранного значения
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "Неявная анимация") {
            Panels {
                Panel.code {
                    """
                    struct TransactionAnimation: View {
                         
                        @State
                        var offset: CGFloat = 50
                         
                        var body: some View {
                         
                            VStack {
                                Image(systemName: "globe")
                                    .imageScale(.large)
                                    .foregroundStyle(.tint)
                                    .offset(x: offset)
                                    .animation(.easeIn(duration: 0.25), value: offset)
                                 
                                Button("Animate") {
                                    offset = 100
                                }
                            }
                        }
                    }
                    """
                }

                Panel.code("Смысл") {
                    """
                    struct AnimationModifier: ViewModifier {
                        let animation: Animation
                        let value: Value
                         
                        func body(content: Content) -> some View { 
                            guard shouldAnimate, oldValue != value else { 
                                return content
                            }
                             
                            var transaction = Transaction()
                            transaction.animation = animation
                            return withTransaction(transaction) {
                                content
                            }
                        }
                    }
                    """
                }
            }
        }
    }
}
