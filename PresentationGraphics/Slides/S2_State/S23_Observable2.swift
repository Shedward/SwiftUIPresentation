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
        e00 {
            "Давайте посмотрим в живую на примере"
            "Допусти у нас есть вот такая вьюха"
        }
        e01 {
            "Для наглядности утащим body в подписку"
        }
        e02 {
            "Запишем тут еще как у нас на самом деле выглядят эти проперти"
            "Если мы запустим приложение в таком виде тело будет вычислено внутри withObservationTracking"
            "И ничего интересного не произойдет"
            "Никакой подписки не будет, т.к. наша вьюха не обратилось ни к одному полю"
            "Ей эти изменения не интересны"
            "И даже если мы нажмем на кнопку вьюха не будет перерисована, т.к. isOnline никак на нее не влияет"
        }
        e03 {
            "Давайте добавим зависимость, например отобразим title"
            "Теперь при вычислении body регистр запомнит что наша вьюха обращалась к title"
            "Ии когда мы нажмем на кнопку, перерисовки не произойдет"
            "Так как при нажатии поменялся только isOnline, а он нам все еще не интересен"
        }
        e04 {
            "Зато, если мы добавим отображение статуса"
            "Тогда при вычислении body регистр запомнит что мы обращались и к title и к isOnline"
            "И при нажатии на кнопку значение изменится и экран перерисуется"
        }
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
