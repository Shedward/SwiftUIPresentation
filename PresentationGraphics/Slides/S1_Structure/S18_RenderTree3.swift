//
//  S17_ViewBuilderIsNotACode.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 20.10.2024.
//

import SwiftUI

struct S18_RenderTree3: View, Slide {

    @Environment(\.episode)
    var episode: String

    var notes: String? {
        """
        e00 - Теперь когда мы поменяем любое значение состояния, то SwiftUI создаст новое Render Tree
        """
    }

    var body: some View {
        TitleSubtitleLayout(title: "Render Tree") {
            Panels {
                Panel.viewTree {
                    Tree("VStack") {
                        Tree("Text", id: "title-text")
                        Tree("Text", id: "body-text")
                            .highlight()
                        Tree("_ConditionalContent") {
                            Tree("ForEach") {
                                Tree("Text", id: "foreach-text-start")
                                    .relation(Relation(dashed: true))
                                Tree("...", id: "foreach-text-mid")
                                    .relation(Relation(dashed: true))
                                Tree("Text", id: "foreach-text-end")
                                    .relation(Relation(dashed: true))
                            }
                            Tree("Text", id: "author-text")
                                .disabled()
                        }.highlight()
                    }
                }

                Panel("Render View") {
                    SpacedVStack {
                        CodeView {
                            "title = \"Что такое SwiftUI?\""
                            "text = \"SwiftUI – это UI фреймворк\""
                                .highlight()
                            "showAuthors = true"
                                .highlight()
                            "authors = [\"Алиса\", \"Боб\", \"Ева\"]"
                        }

                        TreeView(
                            tree: Tree("VStack") {
                                Tree("Text", id: "title-text")
                                    .caption("\"Что такое\nSwiftUI?\"")
                                Tree("Text", id: "body-text")
                                    .caption("\"SwiftUI\n– это UI фреймворк\"")
                                Tree("_ConditionalContent") {
                                    Tree("Text", id: "alice-text")
                                        .caption("\"Алиса\"")
                                    Tree("Text", id: "bob-text")
                                        .caption("\"Боб\"")
                                    Tree("Text", id: "eve-text")
                                        .caption("\"Ева\"")
                                }
                                .caption("true")
                            }
                        )
                    }
                }

                Panel.preview {
                    ArticleView(
                        title: "Что такое SwiftUI?",
                        text: "SwiftUI – это UI фреймворк",
                        showAuthors: true,
                        authors: ["Алиса", "Боб", "Ева"]
                    )
                }
            }
        }
    }
}
