//
//  S17_ViewBuilderIsNotACode.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 20.10.2024.
//

import SwiftUI

struct S18_RenderTree: View, Slide {

    var notes: String? {
        """
        e00 - Итак, у нас есть дерево вьюх описывающее все возможные состояния
        """
    }

    var body: some View {
        TitleSubtitleLayout(title: "Render Tree") {
            Panels {
                Panel.code(font: Theme.Font.codeExtraSmall) {
                    """
                    struct ArticleView: View {
                        
                        let title: String
                        let text: String
                        let showAuthors: Bool
                        let authors: [String]
                        
                        var body: some View {
                            VStack(spacing: 8) {
                                Text(title)
                                    .font(.title)
                                Text(text)
                                    .font(.body)
                                if showAuthors {
                                    ForEach(authors, id: \\.self) { author in
                                        Text(author)
                                            .font(.caption)
                                    }
                                } else {
                                    Text("Authors: \\(authors.count)")
                                        .font(.caption)
                                        .foregroundStyle(Color.white)
                                        .padding([.leading, .trailing], 8)
                                        .background(Color.black)
                                        .clipShape(Capsule())
                                }
                            }
                            .padding()
                            .frame(width: 200)
                        }
                    }
                    """
                }

                Panel.viewTree {
                    Tree(".frame(width: 200)") {
                        Tree(".padding") {
                            Tree("VStack") {
                                Tree(".font(.title)") {
                                    Tree("Text", id: "title-text")
                                }
                                Tree(".font(.body)") {
                                    Tree("Text", id: "body-text")
                                }
                                Tree("_ConditionalContent") {
                                    Tree("ForEach") {
                                        Tree(".font(.caption)", id: "foreach-font-start") {
                                            Tree("Text", id: "foreach-text-start")
                                        }.relation(Relation(dashed: true))
                                        Tree(".font(.caption)", id: "foreach-font-end") {
                                            Tree("Text", id: "foreach-text-end")
                                        }.relation(Relation(dashed: true))
                                    }
                                    Tree("<5>", color: Theme.Color.tintPrimary) {
                                        Tree("Text", id: "author-text")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ArticleView: View {
    let title: String
    let text: String

    let showAuthors: Bool
    let authors: [String]

    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.title)
            Text(text)
                .font(.body)
            if showAuthors {
                ForEach(authors, id: \.self) { author in
                    Text(author)
                        .font(.caption)
                }
            } else {
                Text("Authors: \(authors.count)")
                    .font(.caption)
                    .foregroundStyle(Color.white)
                    .padding([.leading, .trailing], 8)
                    .background(Color.black)
                    .clipShape(Capsule())
            }
        }
        .padding()
        .frame(width: 200)
    }
}

#Preview {
    ArticleView(
        title: "Заголовок",
        text: "Описание статьи  для проверки переноса строк и прочего.",
        showAuthors: false,
        authors: [
            "Автор Авторович",
            "Редактор Редакторович"
        ]
    )
}
