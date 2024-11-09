//
//  S32_Transaction.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

struct S32_Transaction: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - Помните CATransaction?
            - Оказывается в SwiftUI тоже есть свой Transaction
            - И выглядит он очень похоже, и работает тоже очень похоже
            """
        )
        e01(
            """
            - Transaction это структурка в которая хранит настройки поведения анимации
            - В нее мы помещаем timingCurve и продолжительность
            """
        )
        e02(
            """
            - Затем основная магия происходит в withTransaction
            - При вызове withTransaction сначала делается снимок состояния анимируемых значений "до" 
            """
        )
        e03(
            """
            - Затем применяется блок с анимациями и делается снимок состояния анимируемых значений "после"
            """
        )
        e04(
            """
            - И в конце концов запускаем анимацию
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "Transaction") {
            Panels {
                Panel.code {
                    """
                    struct TransactionAnimation: View {
                         
                        @State
                        var offset: CGFloat = 50
                         
                        var body: some View {
                            VStack {
                                Image(systemName: "globe")
                                    .offset(x: offset)
                                 
                                Button("Animate") {
                                    var transaction = Transaction()
                    """
                    "                transaction.animation = .easeIn(duration: 0.25)"
                        .highlight(episode == e01)
                    "                withTransaction(transaction) {"
                        .highlight(episode == e02)
                    "                    offset = 100"
                        .highlight(episode == e03)
                    """
                                    }
                                }
                            }
                        }
                    }
                    """
                }

                Panel.preview {
                    TransactionAnimation()
                }

                Panel.code("Анимация") {
                    showIf(episode, after: e01) {
                        "timingFunction = .easeIn"
                        "duration = 0.25"
                    }
                    "fromValue = 50"
                        .showIf(episode, after: e02)
                    "toValue = 100"
                        .showIf(episode, after: e03)
                }
            }
        }
    }
}
