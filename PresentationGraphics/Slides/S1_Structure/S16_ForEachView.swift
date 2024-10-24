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
                            Tree("id[0]", id: "first-id", relation: .init(dashed: true)) {
                                Tree("Text", id: "first-text")
                            }
                            Tree("...", id: "mid-id", relation: .init(dashed: true)) {
                                Tree("Text", id: "mid-text")
                            }
                            Tree("id[n]", id: "last-id", relation: .init(dashed: true)) {
                                Tree("Text", id: "first-text")
                            }
                        }
                    }
                }.showIf(episode, after: "e01-ForEach")
            }
        }
    }
}
