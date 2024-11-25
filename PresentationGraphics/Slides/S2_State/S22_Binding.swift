//
//  S21_StateModifier4.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 02.11.2024.
//

import SwiftUI

struct S22_Binding: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00 {
            "Дальше у нас есть - биндинг"
            "Его мы используем когда у нас есть состояние пришедшее снаружи и которое мы хотим изменить изнутри"
            "Это почти все контролы и инпуты которые что-то редактируют"
        }

        e01 {
            "Биндинг сам не хранит значение"
            "Биндинг это ссылка за значение лежащее где-то еще"
        }

        e02 {
            "В нашем случае биндинг ссылается на State родительской вьюхи"
        }

        e03 {
            "Сам @Binding это просто структура из геттера и сеттера"
            "Все что он делает это читает устанавливает значение"
        }
    }

    var body: some View {
        TitleSubtitleLayout(title: "@Binding") {
            Panels {
                Panel.code {
                    """
                    struct Counter: View {
                        
                        @Binding
                        var count Int
                        
                        var body: some View {
                            HStack {
                                Text("\\(count)")
                                Button(systemName: "minus") {
                                    count -= 1
                                }
                                Button(systemName: "plus") {
                                    count += 1
                                }
                            }
                        }
                    }
                     
                    struct Main: View {
                        
                        @State 
                        var count: Int
                        
                        var body: some View {
                            HStack {
                                Counter(count: $count)
                                Counter(count: $count)
                                Button("Reset") {
                                    count = 0
                                }
                            }
                        }
                    }
                    """
                }.hideIf(episode, at: e03)

                Panel.code("Binding") {
                    """
                    struct MyBinding<Value> {
                        let getter: () -> Value
                        let setter: (Value) -> Void
                         
                        var wrappedValue: Value {
                            get { getter() }
                            set { setter(newValue) }
                        }
                    }
                    """
                }.showIf(episode, at: e03)

                Panel.renderTree {
                    Tree("Main") {
                        Tree("HStack") {
                            Tree("Counter", id: "counter1")
                                .body {
                                    BindingLabel(name: "count")
                                        .annotatable("binding1")
                                }
                            Tree("Counter", id: "counter2")
                                .body {
                                    BindingLabel(name: "count")
                                        .annotatable("binding2")
                                }
                            Tree("Button")
                                .caption("Reset")
                        }
                    }
                    .body {
                        CurrentStateLabel(name: "count", value: "0")
                            .annotatable("source")
                    }
                    .annotate {
                        if episode >= e02 {
                            LineAnnotation(from: "binding1", to: "source")
                                .bindingKind()
                            LineAnnotation(from: "binding2", to: "source")
                                .bindingKind()
                        }
                    }
                }
                .showIf(episode, after: e01)

                Panel.preview {
                    BindingCounter()
                }
            }
        }
    }
}
