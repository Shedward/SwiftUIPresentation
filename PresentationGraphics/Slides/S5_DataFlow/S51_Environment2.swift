//
//  S30_Animations.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

struct S51_Environment2: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - Еще есть специальный кейс Environment для референс типов
            - До iOS 17 придется использовать ObservableObject + Published
            - С iOS 17 уже можно использовать макрос Observable
            """
        )

        e01(
            """
            - Этот кейс необходим чтобы вьюхи могли подписываться на изменения объекта и обновляться
            - Если value типов достаточно получить изменение значения в дереве, то референс тип может изменится извне.
            - (По той же причине почему у нас вообще есть Observable и ObservableObject для состояний)
            - Из интересных моментов EnvironmentObject
            - 1. Если для value типов мы создавали отдельные ключи, то тут ключом является сам тип объекта
            -    Поэтому в окружение можно положить только один объект определенного типа
            - 2. Для EnvironmentObject'а нет дефолтного значения.
            -    Поэтому если попытаться обратится через @EnvironmentObject когда инстатс еще не выставлен - произойдет краш
            """
        )

        e02(
            """
            - К счастью наша архитектура подразумевает что вся логика у нас происходит во вью модели
            - И прокидывать зависимости напрямую во вьюхи у нас не принято
            - Этой штукой пользоваться этой штукой вам скорее всего не придется никогда
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "EnvironmentObject") {
            Panels {
                Panel.code("До iOS 17") {
                    """
                    class DatabaseClient: ObservableObject {
                        @Published 
                        var status: Status
                    }
                     
                    struct Content: View {
                        let dependencies: Dependencies
                     
                        var body: some View {
                            DatebaseStatusView()
                                .environmentObject(dependencies.databaseClient())
                        }
                    }
                     
                    struct DatabaseStatusView: View {
                        @EnvironmentObject
                        var datebaseClient: DatebaseClient
                         
                        var body: some View {
                            Text("\\(datebaseClient.status)")
                        }
                    }
                    """
                }

                Panel.code("С iOS 17") {
                    """
                    @Observable
                    class DatabaseClient {
                        var status: Status
                    }
                     
                    struct Content: View {
                        var dependencies: Dependencies
                     
                        var body: some View {
                            DatebaseStatusView()
                                .environment(dependencies.databaseClient())
                        }
                    }
                     
                    struct DatabaseStatusView: View {
                        @Environment
                        var datebaseClient: DatebaseClient?
                     
                        var body: some View {
                            Text("\\(datebaseClient?.status ?? "-")")
                        }
                    }
                    """
                }
            }
        }
    }
}
