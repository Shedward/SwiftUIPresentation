//
//  S34_ImplicitExplicit.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 09.11.2024.
//

import SwiftUI

struct S34_ImplicitExplicit: View, Slide {

    var episodes: [Episode] {
        e00(
            """
            - Теперь немного про разные способы задавать транзакцию
            - Мы практически никогда не будем создавать транзакцию вручную
            - Самый простой явный способ - использовать withAnimation
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "Явная анимация") {
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
                                 
                                Button("Animate") {
                    """
                    "                withAnimation(.easeIn(duration: 0.25)) {"
                        .highlight()
                    """
                                        offset = 100
                                    }
                                }
                            }
                        }
                    }
                    """
                }

                Panel.code("Смысл") {
                    """
                    Button("Animate") {
                        var transaction = Transaction()
                        transaction.animation = .easeIn(duration: 0.25)
                        withTransaction(transaction) {
                            offset = 100
                        }
                    }
                    """
                }
            }
        }
    }
}
