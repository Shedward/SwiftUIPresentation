//
//  S17_ViewBuilderIsNotACode.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 20.10.2024.
//

import SwiftUI

struct S18_RenderTree4: View, Slide {

    @Environment(\.episode)
    var episode: String

    var notes: String? {
        """
        e00 - SwiftUI под капотом сравнит новое и отрисованное дерево и составит дифф
        """
    }

    var body: some View {
        TitleSubtitleLayout(title: "Render Tree", subtitle: "Строим diff") {
            SpacedVStack {
                Panels {
                    Panel.renderTree("На экране") {
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

                    Panel.renderTree("После апдейта") {
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
                        path: ["VStack", "2", "_ConditionalContent", "true", "Text"],
                        content: "\"Authors: 3\""
                    )
                    DiffRow(
                        kind: .added,
                        path: ["VStack", "2", "_ConditionalContent", "false", "ForEach"]
                    )
                    DiffRow(
                        kind: .changed,
                        path: ["VStack", "1", "Text"],
                        content: "\"SwiftUI– это инструмент, который...\" → \"SwiftUI – это UI фреймворк\""
                    )
                }
            }
        }
    }
}
