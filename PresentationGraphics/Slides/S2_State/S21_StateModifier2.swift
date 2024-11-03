//
//  S21_StateModifier.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 30.10.2024.
//

import SwiftUI

struct S21_StateModifier2: View, Slide {

    @State
    var externalCount: Int = 3

    @State
    var count: Int = 0

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - Давайте теперь посмотрим на классически ловушки State
            - Для начала давайте прокинем значение извне через инит
            - Ничего работать не будет
            - Значение не меняется ни во вью три ни в рендер три
            """
        )
        e01(
            """
            - Вспомним что у нас тут проперти враппер
            - И поменяем обновление его значение на инит
            - Теперь у нас меняется значение во вью три, но рендер три все равно ничего не делает
            - Чтобы понять почему - давайте глянем на сам State
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(
            title: "@State",
            subtitle: "Инициализация и изменение"
        ) {
            Panels {
                Panel.code {
                """
                struct Counter: View {
                    @State
                    var count: Int
                    
                    init(externalCount: Int) {
                """
                """
                        self.count = externalCount
                """.showIf(episode, at: e00)
                """
                        self._count = State(
                            initialValue: externalCount
                        )
                """.showIf(episode, at: e01)
                """
                    }
                    
                    var body: some View {
                        HStack {
                            Text("\\(count)")
                            Button("minus") {
                                count -= 1
                            }
                            Button("plus") {
                                count += 1
                            }
                        }
                    }
                }
                """
                }

                Panel.viewTree {
                    Tree("Counter") {
                        Tree("HStack") {
                            Tree("Text")
                            Tree("Button", id: "minus-button")
                            Tree("Button", id: "plus-button")
                        }
                    }.body {
                        InitialStateLabel(
                            name: "count",
                            initialValue: "0")
                    }
                }

                Panel.renderTree {
                    Tree("") {
                        Tree("Counter") {
                            Tree("HStack") {
                                Tree("Text")
                                    .caption("\(count)")
                                Tree("Button", id: "minus-button")
                                    .caption("-")
                                Tree("Button", id: "plus-button")
                                    .caption("+")
                            }
                        }
                        .body {
                            CurrentStateLabel(name: "count", value: "\(count)")
                        }
                    }
                    .body {
                        CurrentStateLabel(name: "externalCount", value: "\(externalCount)")
                    }
                }

                Panel.preview {
                    SpacedVStack {
                        Counter(count: $externalCount, title: "externalCount")
                        Counter(count: $count)
                    }
                }
            }
        }
    }
}

private struct CounterWrapper {
    @State
    var counter: Int

    init(counter: Int) {
        self.counter = counter
    }
}
