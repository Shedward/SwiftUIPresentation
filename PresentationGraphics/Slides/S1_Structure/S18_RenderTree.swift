//
//  S17_ViewBuilderIsNotACode.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 20.10.2024.
//

import SwiftUI

struct S18_RenderTree: View, Slide {

    var episodes: [Episode] {
        "e01-ids"
    }

    @Environment(\.episode)
    var episode: String

    var notes: String? {
        """
        e00 - Итак, у нас есть вот такая вьюха
            - И View Tree, описывающее все его состояния, выглядит так
        e01 - Стоит еще упомянуть про id. Каждый из рассмотренных нами контейнеров
            - неявно называет присваивает идентификатор каждой своей подьвюхе по 
              которой он их отличает друг от друга.
            - У тупла вьюху идентифицирует ее положение (0, 1, 2, 3)
            - У _ConditionalContent различает if ветку и else ветку (true, false)
            - У ForEach идентификатор мы определяем сами, это ID у Identifiable,
              либо любое поле по keyPath которое мы указали
            - У тупла эти айдишники статичны, когда вы написали код, айдишники 
              уже определены положением вьюх в структуре
        """
    }

    var body: some View {
        TitleSubtitleLayout(title: "Соберем все вместе") {
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
                            .overline("0".showIf(episode, after: "e01-ids"))
                        Tree("Text", id: "body-text")
                            .overline("1".showIf(episode, after: "e01-ids"))
                        Tree("_ConditionalContent") {
                            Tree("ForEach") {
                                Tree("Text", id: "foreach-text-start")
                                    .relation(Relation(dashed: true))
                                    .overline("authors[0]".showIf(episode, after: "e01-ids"))
                                Tree("...", id: "foreach-text-mid")
                                    .relation(Relation(dashed: true))
                                    .overline("".showIf(episode, after: "e01-ids"))
                                Tree("Text", id: "foreach-text-end")
                                    .relation(Relation(dashed: true))
                                    .overline("authors[n]".showIf(episode, after: "e01-ids"))
                            }
                            .overline("true".showIf(episode, after: "e01-ids"))
                            Tree("Text", id: "author-text")
                                .overline("false".showIf(episode, after: "e01-ids"))
                        }
                        .overline("2".showIf(episode, after: "e01-ids"))
                    }
                }
            }
        }
    }
}
