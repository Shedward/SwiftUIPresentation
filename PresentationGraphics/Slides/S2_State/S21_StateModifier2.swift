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

    var notes: String? {
        """
        e00 - Давайте теперь посмотрим на классически ловушки State\
            - Для начала давайте прокинем значение извне через инит
            - Иии, ничего работать не будет
            - Прям совсем ничего. У нас даже начальное состояние выставляться не будет
        e01 - Поменяли присвоение на инициализацию
        """
    }

    @Environment(\.episode)
    var episode: String

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
                """
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
                            CurrentStateLabel(name: "count", initialValue: "\(count)")
                        }
                    }
                    .body {
                        CurrentStateLabel(name: "externalCount", initialValue: "\(externalCount)")
                    }
                }.hideIf(episode, at:  "e01-что-такое-state")

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
