//
//  S17_ViewBuilderIsNotACode.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 20.10.2024.
//

import SwiftUI

struct S18_RenderTree: View, Slide {

    @Environment(\.episode)
    var episode: String

    var notes: String? {
        """
        e00 - Итак, у нас есть вот такая вьюха
            - И View Tree, описывающее все его состояния, выглядит так
        """
    }

    var body: some View {
        TitleSubtitleLayout(title: "Render Tree") {
            Panels {
                Panel.code {
                    """
                    struct ArticleView: View {
                        
                        let title: String
                        let text: String
                        let showAuthors: Bool
                        let authors: [String]
                        
                        var body: some View {
                            VStack {
                                Text(title)
                                Text(text)
                                if showAuthors {
                                    ForEach(authors, id: \\.self) { author in
                                        Text(author)
                                    }
                                } else {
                                    Text("Authors: \\(authors.count)")
                                }
                            }
                        }
                    }
                    """
                }

                Panel.viewTree {
                    Tree("VStack") {
                        Tree("Text", id: "title-text")
                        Tree("Text", id: "body-text")
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
        .foregroundStyle(.black)
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
