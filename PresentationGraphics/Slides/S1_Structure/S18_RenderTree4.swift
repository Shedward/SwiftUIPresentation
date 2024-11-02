//
//  S17_ViewBuilderIsNotACode.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 20.10.2024.
//

import SwiftUI

struct S18_RenderTree4: View, Slide {

    var episodes: [Episode] {
        e00(
            """
            - SwiftUI под капотом сравнит новое и отрисованное дерево и составит дифф
            - Обратите внимание что этот дифф составляется по айдишникам
            - Путь из айдишников и типов по которому мы идем от рута до вьюхи - определяет ее
            - Если путь сохранен - вьюха та же самая и обновляется, 
            - Если путь отличается - то старая вьюха удаляется, новая добавляется
            - Даже если структура вьюх 
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "Render Tree", subtitle: "Строим diff") {
            SpacedVStack {
                Panels {
                    Panel.renderTree("До") {
                        Tree("VStack") {
                            Tree("Text", id: "title-text")
                                .caption("\"Что такое\nSwiftUI?\"")
                                .overline("0")
                            Tree("Text", id: "body-text")
                                .caption("\"SwiftUI\n– это инструмент,\nкоторый...\"")
                                .overline("1")
                                .diff(.changed)
                            Tree("_ConditionalContent") {
                                Tree("Text", id: "author-text")
                                    .caption("\"Authors: 3\"")
                                    .overline("false")
                                    .diff(.removed)
                            }
                            .caption("false")
                            .overline("2")
                        }
                    }

                    Panel.renderTree("После") {
                        Tree("VStack") {
                            Tree("Text", id: "title-text")
                                .caption("\"Что такое\nSwiftUI?\"")
                                .overline("0")
                            Tree("Text", id: "body-text")
                                .caption("\"SwiftUI\n– это UI фреймворк\"")
                                .overline("1")
                                .diff(.changed)
                            Tree("_ConditionalContent") {
                                Tree("ForEach") {
                                    Tree("Text", id: "alice-text")
                                        .caption("\"Алиса\"")
                                        .overline("Алиса")
                                        .diff(.added)
                                    Tree("Text", id: "bob-text")
                                        .caption("\"Боб\"")
                                        .overline("Боб")
                                        .diff(.added)
                                    Tree("Text", id: "eve-text")
                                        .caption("\"Ева\"")
                                        .overline("Ева")
                                        .diff(.added)
                                }
                                .overline("true")
                                .diff(.added)
                            }
                            .caption("true")
                            .overline("2")
                        }
                    }
                }

                DiffView {
                    DiffRow(
                        kind: .removed,
                        path: ["VStack[2]", "_ConditionalContent[true]", "Text"],
                        content: "\"Authors: 3\""
                    )
                    DiffRow(
                        kind: .added,
                        path: ["VStack[2]", "_ConditionalContent[false]", "ForEach"]
                    )
                    DiffRow(
                        kind: .added,
                        path: ["VStack[2]", "_ConditionalContent[false]", "ForEach[Алиса]", "Text"],
                        content: "Алиса"
                    )
                    DiffRow(
                        kind: .added,
                        path: ["VStack[2]", "_ConditionalContent[false]", "ForEach[Боб]", "Text"],
                        content: "Боб"
                    )
                    DiffRow(
                        kind: .added,
                        path: ["VStack[2]", "_ConditionalContent[false]", "ForEach[Ева]", "Text"],
                        content: "Ева"
                    )
                    DiffRow(
                        kind: .changed,
                        path: ["VStack[1]", "Text"],
                        content: "\"SwiftUI– это инструмент, который...\" → \"SwiftUI – это UI фреймворк\""
                    )
                }
            }
        }
    }
}
