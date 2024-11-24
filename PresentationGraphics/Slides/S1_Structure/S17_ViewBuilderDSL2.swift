//
//  S17_ViewBuilderIsNotACode.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 20.10.2024.
//

import SwiftUI

struct S17_ViewBuilderDSL2: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00 {
            "Соберем все вместе в одну вьюху"
            "Получим вот такое ViewTree"
            "ViewTree по сути описывает все возможные состояния вьюхи под любое состояние"
            "Все ветки использования сохраняются в ее структуре"
        }
        e01 {
            "Еще стоит упомянуть про id"
            "Внутри дерева вьюх каждый узел имеет свой явный или неявный id"
            "Неявный id генерируется автоматически у контейнеров"
            "- У тупла вьюху идентифицирует ее положение (0, 1, 2, 3)"
            "- У _ConditionalContent различает if ветку и else ветку (true, false)"
            "- У ForEach идентификатор определяется id модели"
        }

        e02 {
            "Так же мы можем вручную выставить id с помощью модификатора .id"
            "id может быть любой Hashable"
            "Идентичность вьюхи определяет путь из id'шников до этой вьюхи"
            "Одинаковые путь из id-шников - одина и та же вьюха"
        }
    }

    var body: some View {
        TitleSubtitleLayout(title: "Идентичность ViewTree") {
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
                    """
                    "               .id(titleId)"
                        .showIf(episode, after: e02)
                    """
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
                        if episode < e02 {
                            Tree("Text", id: "title-text")
                                .overline("0".showIf(episode, after: e01))
                        } else {
                            Tree("id(titleId)") {
                                Tree("Text", id: "title-text")
                                    .overline("0".showIf(episode, after: e01))
                            }
                            .overline("titleId")
                        }
                        Tree("Text", id: "body-text")
                            .overline("1".showIf(episode, after: e01))
                        Tree("_ConditionalContent") {
                            Tree("ForEach") {
                                Tree("Text", id: "foreach-text-start")
                                    .relation(Relation(dashed: true))
                                    .overline("authors[0]".showIf(episode, after: e01))
                                Tree("...", id: "foreach-text-mid")
                                    .relation(Relation(dashed: true))
                                    .overline("".showIf(episode, after: e01))
                                Tree("Text", id: "foreach-text-end")
                                    .relation(Relation(dashed: true))
                                    .overline("authors[n]".showIf(episode, after: e01))
                            }
                            .overline("true".showIf(episode, after: e01))
                            Tree("Text", id: "author-text")
                                .overline("false".showIf(episode, after: e01))
                        }
                        .overline("2".showIf(episode, after: e01))
                    }
                }
            }
        }
    }
}
