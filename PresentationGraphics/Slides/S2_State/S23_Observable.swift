//
//  S23_Observable.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 03.11.2024.
//

import SwiftUI

struct S23_Observable: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00 {
            "Еще один вариант - мы можем хранить состояние в полноценном референс объекте"
            "Чтобы вью реагировала на изменения в объекте мы должны пометить объект как @Observable"
            "@State здесь создает создает хранилище привязанное к времени жизни вьюхи"
            "Если @State убрать то модель будет создаваться множество раз под каждый рендер"
        }

        e01 {
            "Более интересный кейс когда объект приходит извне"
            "Он может прийти откуда угодно, из DI, из других вьюх и т.д."
            "При этом этот объект мы можем изменять извне"
            "Реагировать на сеть, на запросы других экранов, на таймеры и т.д."
            "Любые изменения в модели сообщат всем заинтересованым вьюхам перерисоваться"
            "Чтобы посмотреть как это работает давайте развернем макрос Observable"
        }

        e02 {
            "Простейшая модель развернется в такое"
            "Во первых у модели появится некий обзервейшн регист"
            "Во вторых все мутабельные свойства будут завернуты в такую конструкцию"
            "В этой конструкции все обращения к полю будут записаны в регистр"
            "И все изменения поля будут происходить через этот регистр"
            "Так же обратите внимание что регист запоминает к КАКОМУ полю происходил доступ"
        }

        e03 {
            "Со стороны вьюхи - подпись на изменения выглядит примерно так"
            "Используется метод withObservationTracking"
            "Внутри которого вычисляется body"
            "Регист у модели запоминает все поля до которых происходил доступ в теле withObservationTracking"
            "И если какое-то из этих полей поменяется - будет вызван метод onChange"
        }
    }

    var body: some View {
        TitleSubtitleLayout(title: "@Observable", subtitle: "Что это такое") {
            Panels {
                showIf(episode, at: e00) {
                    Panel.code("Внутренняя модель") {
                        """
                        @Observable
                        final class Model {
                            var value = 0
                        }
                         
                        struct Counter: View {
                            @State 
                            private var model = Model()
                             
                            var body: some View {
                                Button("Increment: \\(model.value)") {
                                    model.value += 1
                                }
                            }
                        }
                         
                        struct Main: View {
                            var body: some View {
                                Counter()
                            }
                        }
                        """
                    }
                }

                showIf(episode, after: e01) {
                    Panel.code("Render Cycle") {
                        """
                        let body = withObservationTracking {
                            view.body
                        } onChange: {
                            view.needUpdate()
                        }
                        
                        render(body)
                        """
                    }.showIf(episode, after: e03)

                    Panel.code("Внешняя модель") {
                        showIf(episode, at: e01) {
                            """
                            @Observable
                            final class Model {
                                var value = 0
                            }
                             
                            """
                        }
                        showIf(episode, after: e02) {
                            """
                            final class Model {
                                 private let _observationRegistrar = 
                                    ObservationRegistrar()
                                 
                                private var _value: Int = 0
                                var value: Int {
                                    get {
                                        _observationRegistrar.access(
                                            keyPath: \\.value
                                        )
                                        return _value
                                    }
                                     
                                    set {
                                        _observationRegistrar.withMutation(
                                            keyPath: \\.value
                                        ) {
                                            _value = newValue
                                        }
                                    }
                                }
                            }
                            """
                        }

                        """
                        struct Counter: View {
                            private let model: Model
                             
                            var body: some View {
                                Button("Increment: \\(model.value)") {
                                    model.value += 1
                                }
                            }
                        }
                        
                        struct Main: View {
                            var body: some View {
                                Counter(model: dependencies.counterModel)
                            }
                        }
                        """
                    }

                    Panel.renderTree {
                        Tree("") {
                            Tree("Main") {
                                Tree("Counter")
                            }
                        }
                    }
                }
            }
        }
    }
}
