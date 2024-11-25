//
//  S21_StateModifier.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 30.10.2024.
//

import SwiftUI

struct S21_StateModifier3: View, Slide {

    @State
    var externalCount: Int = 3

    @State
    var count: Int = 0

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00 {
            "State это проперти враппер, который транслирует значение из внешнего хранилища"
            "И не хранит его сам"
        }
        e01 {
            "И есть нюанс"
            "Хранилище это привязано к жизни вьюхи в AttributeGraph"
            "Пока нет AttributeGraph - нет хранилища"
            "Поэтому у стейта - разделяется инициализация и обновление"
            "Инициализация происходит в ViewTree"
            "А обновление может происходит только в RenderTree"
            "Поэтому во View Tree у меня написано count from 0"
            "Поэтому в Render Tree уже хранятся сами значения"
        }
        e02 {
            "Поэтому значение которое мы передадим как initalState будет выставлятся только при добавлении вьюхи"
            "А пока вьюха на экране - стейт изменятся не будет"
        }
    }

    var body: some View {
        TitleSubtitleLayout(
            title: "@State",
            subtitle: "Что это такое"
        ) {
            Panels {
                Panel.code("State") {
                    """
                    @propertyWrapper
                    struct State<Value> {
                        let initialValue: Value
                        private let valueStorage: _Storage?
                        
                    """
                    """
                        init(wrappedValue: Value) {
                            self.initialValue = wrappedValue
                        }
                        
                        init(initialValue: Value) {
                            self.init(wrappedValue: initialValue)
                        }
                    """
                            .highlight(episode >= e01 ? Theme.Color.tintPrimary.opacity(0.3) : nil)
                    " "
                    """
                        var wrappedValue: Value {
                            get { valueStorage?.get() ?? initialValue }
                            nonmutating set {
                                valueStorage?.update(newValue)
                            }
                        }
                    """
                            .highlight(episode >= e01 ? Theme.Color.tintSecondary.opacity(0.3) : nil)
                    """
                    }
                    """
                }.hideIf(episode, after: e02)

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
                .showIf(episode, after: e01)

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
                            CurrentStateLabel(name: "count", value: "...")
                        }
                    }
                    .body {
                        CurrentStateLabel(name: "externalCount", value: "...")
                    }
                }
                .showIf(episode, after: e01)

                Panel.preview {
                    ReloadingCounter()
                }
                .showIf(episode, after: e02)
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
