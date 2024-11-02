//
//  S17_ViewBuilderIsNotACode.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 20.10.2024.
//

import SwiftUI

struct S18_RenderTree2: View, Slide {

    @Environment(\.episode)
    var episode: String

    var notes: String? {
        """
        e00 - Чтобы отрисовать эту вьюху мы инстанциируем ее с определенным состоянием, допустим ... 
            - Дальше мы вычисляем body с выбранными значениями и получаем Render Tree
            - На основе этого render tree, SwiftUI рисует на экране соответствующий интерфейс
        """
    }

    var body: some View {
        TitleSubtitleLayout(title: "Render Tree", subtitle: "Изначальное состояние") {
            Panels {
                Panel.viewTree {
                    Tree("VStack") {
                        Tree("Text", id: "title-text")
                            .overline("0")
                        Tree("Text", id: "body-text")
                            .overline("1")
                        Tree("_ConditionalContent") {
                            Tree("ForEach") {
                                Tree("Text", id: "foreach-text-start")
                                    .relation(Relation(dashed: true))
                                    .overline("authors[0]")
                                    .disabled()
                                Tree("...", id: "foreach-text-mid")
                                    .relation(Relation(dashed: true))
                                    .overline("")
                                    .disabled()
                                Tree("Text", id: "foreach-text-end")
                                    .relation(Relation(dashed: true))
                                    .overline("authors[n]")
                                    .disabled()
                            }
                            .overline("true")
                            .disabled()
                            Tree("Text", id: "author-text")
                                .overline("false")
                        }
                        .overline("2")
                    }
                }

                Panel("Render Tree") {
                    SpacedVStack {
                        CodeView {
                            """
                            title = "Что такое SwiftUI?"
                            text = "SwiftUI – это инструмент, который..."
                            showAuthors = false
                            authors = ["Алиса", "Боб", "Ева"]
                            """
                        }

                        TreeView(
                            tree: Self.renderTree
                        )
                        .relation(.renderTree)
                    }
                }

                Panel.preview {
                    ArticleView(
                        title: "Что такое SwiftUI?",
                        text: "SwiftUI – это инструмент, который...",
                        showAuthors: false,
                        authors: ["Алиса", "Боб", "Ева"]
                    )
                }
            }
        }
    }

    static var renderTree: Tree {
        Tree("VStack") {
            Tree("Text", id: "title-text")
                .caption("\"Что такое\nSwiftUI?\"")
                .overline("0")
            Tree("Text", id: "body-text")
                .caption("\"SwiftUI\n– это инструмент,\nкоторый...\"")
                .overline("1")
            Tree("_ConditionalContent") {
                Tree("Text", id: "author-text")
                    .caption("\"Authors: 3\"")
                    .overline("false")
            }
            .caption("false")
            .overline("2")
        }
    }
}
