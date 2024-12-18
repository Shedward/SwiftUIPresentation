//
//  S17_ViewBuilderIsNotACode.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 20.10.2024.
//

import SwiftUI

struct S18_RenderTree3: View, Slide {

    var episodes: [Episode] {
        e00 {
            "Теперь изменим состояние"
            "При изменении состояния SwiftUI создает новое Render Tree"
        }
    }

    var body: some View {
        TitleSubtitleLayout(title: "Render Tree", subtitle: "После изменения состояния") {
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
                                Tree("...", id: "foreach-text-mid")
                                    .relation(Relation(dashed: true))
                                    .overline("")
                                Tree("Text", id: "foreach-text-end")
                                    .relation(Relation(dashed: true))
                                    .overline("authors[n]")
                            }
                            .overline("true")
                            Tree("Text", id: "author-text")
                                .overline("false")
                                .disabled()
                        }
                        .overline("2")
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

                        TreeView(Self.renderTree)
                            .relation(.renderTree)
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

    static var renderTree: Tree {
        Tree("VStack") {
            Tree("Text", id: "title-text")
                .caption("\"Что такое\nSwiftUI?\"")
                .overline("0")
            Tree("Text", id: "body-text")
                .caption("\"SwiftUI\n– это UI фреймворк\"")
                .overline("1")
            Tree("_ConditionalContent") {
                Tree("ForEach") {
                    Tree("Text", id: "alice-text")
                        .caption("\"Алиса\"")
                        .overline("Алиса")
                    Tree("Text", id: "bob-text")
                        .caption("\"Боб\"")
                        .overline("Боб")
                    Tree("Text", id: "eve-text")
                        .caption("\"Ева\"")
                        .overline("Ева")
                }
                .overline("true")
            }
            .caption("true")
            .overline("2")
        }
    }
}
