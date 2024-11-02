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

    var notes: String? {
        """
        e00 - Чтобы понять почему - глянем на то как State реализован
            - State это проперти враппер, который под капотом транслирует внешнее хранилице состояния
            - (аналогия с чертежом дома и жителями дома)
        e01 - Инит - это чертеж, State - это уже построенная вьюха
        """
    }

    @Environment(\.episode)
    var episode: String

    var episodes: [Episode] {
        "e01-two-domains"
    }

    var body: some View {
        TitleSubtitleLayout(
            title: "@State",
            subtitle: "Что такое"
        ) {
            Panels {
                Panel.code("State") {
                """
                @propertyWrapper
                struct State<Value> {
                    let initialValue: Value
                    private let valueStorage: _SwiftUIValueStorage
                    
                """
                """
                    init(wrappedValue: Value) {
                        self.initialValue = wrappedValue
                        self.valueStorage = _SwiftUIValueStorage(
                            initialValue: wrappedValue
                        )
                    }
                    
                    init(initialValue: Value) {
                        self.init(wrappedValue: initialValue)
                    }
                """
                        .highlight(episode >= "e01-two-domains" ? Theme.Color.tintPrimary.opacity(0.3) : nil)
                " "
                """
                    var wrappedValue: Value {
                        get { valueStorage.get() }
                        nonmutating set {
                            valueStorage.update(newValue)
                        }
                    }
                """
                        .highlight(episode >= "e01-two-domains" ? Theme.Color.tintSecondary.opacity(0.3) : nil)
                """
                }
                """
                }

                Panel.code("Использование") {
                """
                struct Counter: View {
                    @State
                    var count: Int
                    
                """
                """
                    init(externalCount: Int) {
                        self._count = .init(initialValue: externalCount)
                    }
                """
                    .highlight(episode >= "e01-two-domains" ? Theme.Color.tintPrimary.opacity(0.3) : nil)
                " "
                """
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
                    .highlight(episode >= "e01-two-domains" ? Theme.Color.tintSecondary.opacity(0.3) : nil)
                }

                Panel("Деревья") {
                    SpacedVStack {
                        TreeView(
                            tree: Tree("") {
                                Tree("Counter")
                                    .body {
                                        InitialStateLabel(name: "count", initialValue: "0")
                                    }
                            }
                        )
                        .relation(.viewTree)

                        TreeView(
                            tree: Tree("") {
                                Tree("Counter")
                                    .body {
                                        CurrentStateLabel(name: "count", initialValue: "0")
                                    }
                            }
                        )
                        .relation(.renderTree)
                    }
                }
                .showIf(episode, after: "e01-two-domains")
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
