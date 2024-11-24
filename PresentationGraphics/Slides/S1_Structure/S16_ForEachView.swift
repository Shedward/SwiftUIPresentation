//
//  S16_ForView.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 20.10.2024.
//

import SwiftUI

struct S16_ForEachView: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00 {
            "И последнее что мы хотели бы делать в билдере - циклы"
            "Напрямую for или while использовать мы не можем"
            "Но можем использовать ForEach"
        }
        e01 {
            "ForEach в дереве - динамическое дерево элементы которого зависят от модели"
            "При этом элементы его привязаны по id'шнику модели"
        }
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
                }.showIf(episode, after: e01)
            }
        }
    }
}
