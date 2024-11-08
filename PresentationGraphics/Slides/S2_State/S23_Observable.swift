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
        e00(
            """
            - Еще один вариант - мы можем хранить состояние в полноценном объекте
            - @State здесь создает создает хранилище привязанное к времени жизни вьюхи
            - Если @State убрать то модель будет создаваться множество раз под каждый ререндер
            """
        )

        e01(
            """
            - Более интересный кейс это когда объект приходит извне
            - Этот объект может приходит откуда угодно, из DI, из других вьюх и т.д.
            - При этом этот объект мы изменять можем извне. 
            - Реагировать на сеть, на запросы других экранов и т.д.
            - Любые изменения в модели сигнализируют вьюхе о необходимости перерисоваться
            """
        )

        e02(
            """
            - Как это работает?
            - @Observable это макрос который заворачивает доступ к каждому изменяемому полю 
            - При этом у класса появляется ObservationRegistrar который следит за изменениями
            - Обратите внимание - регистр следит не только за фактом изменения поля, но и за фактом доступа к нему
            - К тому же регистр записывает кейпас к которому произошла запись
            - Observation'у эта информация нужна потому что он не просто обновляет все по каждому изменению
            - А обновляет только при изменении значений к которым *был запрошен доступ*
            """
        )

        e03(
            """
            - Со стороны вьюхи - подпись на изменения выглядит так 
            - Мы подписываемся на изменения всех значений доступ к которым происходит в блоке
            - При этом при изменениях обзервейшн дернет onChange
            """
        )
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
