//
//  S23_Observable.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 03.11.2024.
//

import SwiftUI

struct S23_Observable2: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - В живую это будет выглядеть примерно так
            - Предположим что у нас есть вот такая вьюха
            """
        )
        e01(
            """
            - Для наглядности утащим body в подписку
            """
        )
        e02(
            """
            - Теперь когда SwiftUI будет рендерить вью body выполнится внутри withObservationTracking
            - Но в нашем текущем случае обзервейшн не будет установлен. 
            - Так как мы не используем никакие поля из модели для отображения
            - Хотя если мы нажмем кнопку - поле поменяется, но перерисовки не будет
            """
        )
        e03(
            """
            - Давайте добавим зависимость, например отобразим title
            - Теперь при вычислении body регистр сохранит обращение к title
            - Но при нажатии на кнопку у нас перерисовки не произойдет
            - Так как при нажатии на кнопку меняется только isOnline
            """
        )
        e04(
            """
            - Зато, если мы добавим отображение статуса
            - Тогда при вычислении body регистр запомнит что мы обращались и к title и к isOnline
            - И при нажатии на кнопку и изменению значения isOnline обзервейшнт дернет onChange
            - Что приведет к перерисовке экрана
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "@Observable", subtitle: "Пример") {
            Panels {
                Panel.code("Render Cycle") {
                    """
                    let body = withObservationTracking {
                    """
                    showIf(episode, at: e00) {
                        "    view.body"
                    }
                    showIf(episode, after: e01) {
                        bodyCode
                    }
                    """
                    } onChange: {
                        view.needUpdate()
                    }
                    
                    render(body)
                    """
                }

                Panel.code {
                    """
                    @Observable
                    final class Model {
                        var title = "Title"
                        var subtitle = "Subtitle"
                        var isOnline: Bool
                    """
                    """
                         
                        // var field: Field {
                        //     get {
                        //         r.access(\\.field)
                        //         return _field
                        //     }
                        //
                        //      set {
                        //          r.withMutation(\\.field) {
                        //              _field = newValue
                        //          }
                        //      }
                        //  }
                    """.showIf(episode, after: e02)
                    """
                    }
                    """
                    showIf(episode, at: e00) {
                        """
                         
                        struct ModelView: View {
                            let model: Model
                             
                            var body: some View {
                                VStack {
                                    Button("Go online") {
                                        model.isOnline = true
                                    }
                                }
                            }
                        }
                        """
                    }
                }

                Panel.code("ObservationRegistrar") {
                    """
                    class ObservationRegistrar {
                    
                        let observations = [
                    """
                    showIf(episode, at: e03) {
                        """
                                Observation(
                                    for: [ \\.title ], 
                                    onChange: { view.needUpdate() }
                                )
                        """.highlight()
                    }
                    showIf(episode, at: e04) {
                        """
                                Observation(
                                    for: [ \\.title, \\.isOnline ], 
                                    onChange: { view.needUpdate() }
                                )
                        """.highlight()
                    }
                    """
                        ]
                        
                        func access(keyPath: KeyPath) { 
                            ... 
                        }
                    
                        func withMutation(
                            keyPath: KeyPath, 
                            action: () -> Void
                        ) {
                            ...
                        }
                    }
                    """
                }
            }
        }
    }

    @CodeBuilder
    var bodyCode: [CodePart] {
        """
            VStack {
        """
        showIf(episode, after: e03) {
            "        Text(model.title)"
                .highlight(episode == e03)
        }
        showIf(episode, after: e04) {
            """
                    Text(
                        model.isOnline 
                        ? "Online" : "Offline"
                    )
            """
                .highlight(episode == e04)
        }
        """
                Button("Go online") {
                    model.isOnline = true
                }
            }
        """
    }
}
