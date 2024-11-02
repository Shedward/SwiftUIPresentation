//
//  S16_ForView.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 20.10.2024.
//

import SwiftUI

struct S16_ForEachView: View, Slide {

    @Environment(\.episode)
    var episode: String

    var episodes: [Episode] {
        "e01-ForEach"
    }

    var notes: String? {
        """
        e00 - И последнее что мы хотели бы делать в билдере - циклы
            - Для того чтобы мапить коллекции в элементы экрана
            - Но for нам недоступен и доступен только ForEach
        e01 - ForEach подразумевает динамическое дерево, элементы которого напрямую зависят от модели к которой ForEach привязан
            - Не просто так мы ограничены использованием ForEach вместо стандартных циклов for/while/и т.д.
            - Для работы с коллекциями нам нужен уникальный идентификатор для каждого элемента
        """
    }

    var body: some View {
        TitleSubtitleLayout(title: "Цикл") {
            Panels {
                Panel.code {
                    """
                    struct GuestList: View {
                        let guestNames: [String]

                        var body: some View {
                            List {
                                ForEach(guestNames, id: \\.self) { name in
                                    Text(name)
                                }
                            }
                        }
                    }
                    """
                }

                Panel.viewTree {
                    Tree("List") {
                        Tree("ForEach<String>") {
                            Tree("Text", id: "first-text")
                                .overline("id[0]")
                                .relation(.viewTree.dashed())
                            Tree("...", id: "mid-text")
                                .overline("")
                                .relation(.viewTree.dashed())
                            Tree("Text", id: "last-text")
                                .overline("id[n]")
                                .relation(.viewTree.dashed())
                        }
                    }
                }.showIf(episode, after: "e01-ForEach")
            }
        }
    }
}
