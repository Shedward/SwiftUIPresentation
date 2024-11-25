//
//  S30_Animations.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

struct S51_Environment: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - Начнем сначала со способа передавать информацию от родителей ко всем детям
            - Стандартный пример у нас есть некая тема и мы хотим использовать эту тему
            по всему приложению
            - Стандартными способами мы бы написали это например так
            - Но вместо этого мы можем положить любое значение в Environment 
            - И оно будет доступно из любой вьюхи
            """
        )

        e01(
            """
            - Для этого нам нужно объявить ключ по которому будет храниться это значение
            - указав дефолтное
            - И можно расширить EnvironmentValues чтобы это значение было удобнее использовать
            """
        )

        e02(
            """
            - И затем где-нибудь в корне мы укажем значение через .environment
            - А для того чтобы достать актуальное значение используем проперти врапер Environment
            - который будет читать актуальное из окружения
            """
        )

        e03(
            """
            - Значения эти хранятся у нас в структуре под названием EnvironmentValues
            - По своей сути это просто словарь с ключом-типом
            - Такой паттерн кстати будет встречаться в SwiftUI ну очень часто
            - У EnvironmentValues есть два свойства - значение в нем можно поменять
            - И если значение не было изменено то берется то что прописано в defaultValue у ключа
            """
        )

        e04(
            """
            - По месту использования проперти враппер Environment по сути берет текущий EnvironmentValues
            - и вытаскивает из него актуальное значение
            - При этом работать этот проперти враппер может только в контексте вьюхи
            - Если попытаться изпользовать его где-то еще вы получите всегда дефолное значение
            - и варнинг о том что произошел доступ до Environment'а вне контекста вьюхи
            - EnvironmentValues.current это если что условность. Не особо известно как там точно реализовано
            - Но для примера тут я это представлю как глобальную переменную
            """
        )

        e05(
            """
            - С другой стороны, для того чтобы установить значение у нас есть модификатор .environment
            - Который по сути для своих чайлдов меняет одно поле EnvironmentValues на выбранное нами значение
            """
        )

        e06(
            """
            - Для наглядности давайте посмотрим как это выглядит в дереве отрисовки
            - Для начала без выставленного значения
            """
        )

        Episode(
            "e06-01",
            notes: "- Если ничего не выставлено, то значение будет браться из значения по умолчанию"
        )

        Episode(
            "e06-02",
            notes: "- Мы можем навесить тему на самый корень"
        )

        Episode(
            "e06-03",
            notes: 
                """
                - А можем и на любое подерево
                - Таким образом мы можем настраивать целые куски интерфейса произвольным образом
                """
        )

        e07(
            """
            - На самом деле почти все глобальные настройки UI уже прокинуты через Environemnt
            - А так же очень многие настройки нативных компонентов выставляются через него
            - Поэтому во многих нативных SwiftUI компонентах 
            - часто можно не дублировать модификатор, а выставить его во внешней вьюхе
            - И еще из интересного - SwiftUI достаточно умный чтобы следить за обновлением окружения
            - для вьюх, и обновлять только те вьюхи которые environment используют
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "Environment") {
            Panels {
                Panel.code("Model") {
                    """
                    struct ColorTheme {
                        let content: Color
                        let background: Color
                         
                        static let light = ColorTheme(
                            content: .black, 
                            background: .white
                        )
                         
                        static let dark = ColorTheme(
                            content: .white, 
                            background: .black
                        )
                    }
                    """
                }
                .showIf(episode, at: e00)

                Panel.code("Environment") {
                    """
                    enum ColorThemeKey: EnvironmentKey {
                        static let defaultValue: ColorTheme = .light
                    }
                    """
                    """
                     
                    struct EnvironmentValues {
                        private let values: [EnvironmentKey: Any] = [:]
                    
                        public subscript<K>(key: K.Type) -> K.Value where K : EnvironmentKey {
                            ...
                        }
                    }
                    """
                        .showIf(episode, after: e03)
                    """
                     
                    extension EnvironmentValues {
                        var colorTheme: ColorTheme {
                            get { self[ColorThemeKey.self] }
                            set { self[ColorThemeKey.self] = newValue }
                        }
                    }
                    """
                    """
                     
                    @propertyWrapper
                    struct Environment<Value> {
                        private let keyPath: WritableKeyPath<EnvironmentValues, Value>

                        var wrappedValue: Value {
                            let values = EnvironmentValues.current ?? EnvironmentValues()
                            return values[keyPath: keyPath]
                        }
                    }
                    """
                        .showIf(episode, after: e04)

                    """
                     
                    extension View {
                        func environment<Content: View, Key: EnvironmentKey>(
                            key: Key,
                            newValue: Key.Value
                            content: () -> Content
                        ) -> some View {
                            let globalEnvironment = EnvironmentValues.current
                            defer { EnvironmentValues.current = globalEnvironment }
                             
                            EnvironmentValues.current[key] = newValue
                            return content()
                        }
                    }
                    """
                        .showIf(episode, after: e05)
                }
                .showIf(episode, in: e01...e05)

                Panel.code("Использование") {
                    "struct Heart: View {"
                    "    @Environment(\\.colorTheme)"
                        .showIf(episode, after: e02)?
                        .highlight(episode == e02)
                    "    var theme: ColorTheme"
                    " "
                    "    var body: some View {"
                    "        Text(\"♥\")"
                    "            .foregroundColor(theme.content)"
                    "            .background(theme.background)"
                    "    }"
                    "}"
                    " "
                    "struct Content: View {"
                    "    let theme: ColorTheme"
                        .hideIf(episode, after: e02)
                    " "
                    "    VStack {"
                    "        Heart(\(heartParams))"
                    "        HStack {"
                    "            Heart(\(heartParams))"
                    "            Heart(\(heartParams))"
                    "        }"
                    "        .environment(\\.colorTheme, .light)"
                        .showIf(episode, after: Episode("e06-03"))?
                        .highlight(episode == Episode("e06-03"))
                    "        Heart(\(heartParams))"
                    "    }"
                    "    .environment(\\.colorTheme, .dark)"
                        .showIf(episode, in: e02...e05)?
                        .highlight(episode == e02)
                    "    .environment(\\.colorTheme, .dark)"
                        .showIf(episode, after: Episode("e06-02"))?
                        .highlight(episode == Episode("e06-02"))
                    "}"
                }

                Panel.renderTree("Без выставления") {
                    Tree("VStack") {
                        Tree("Heart", id: "heart1")
                            .body {
                                ShowIf(at: Episode("e06-01")) {
                                    EnvironmentValueLabel(value: ".light", mode: .used)
                                }
                            }
                        Tree("HStack") {
                            Tree("Heart", id: "heart2")
                                .body {
                                    ShowIf(at: Episode("e06-01")) {
                                        EnvironmentValueLabel(value: ".light", mode: .used)
                                    }
                                }
                            Tree("Heart", id: "heart3")
                                .body {
                                    ShowIf(at: Episode("e06-01")) {
                                        EnvironmentValueLabel(value: ".light", mode: .used)
                                    }
                                }
                        }
                        .body {
                            ShowIf(at: Episode("e06-01")) {
                                EnvironmentValueLabel(value: ".light")
                            }
                        }
                        Tree("Heart", id: "heart4")
                            .body {
                                ShowIf(at: Episode("e06-01")) {
                                    EnvironmentValueLabel(value: ".light", mode: .used)
                                }
                            }
                    }
                    .body {
                        ShowIf(at: Episode("e06-01")) {
                            EnvironmentValueLabel(value: ".light")
                        }
                    }
                }.showIf(episode, in: e06...Episode("e06-01"))

                Panel.renderTree("С выставлением") {
                    Tree(".environment") {
                        Tree("VStack") {
                            Tree("Heart", id: "heart21")
                                .body {
                                    EnvironmentValueLabel(value: ".dark", mode: .used)
                                }
                            Tree("HStack") {
                                Tree("Heart", id: "heart22")
                                    .body {
                                        EnvironmentValueLabel(value: ".dark", mode: .used)
                                    }
                                Tree("Heart", id: "heart23")
                                    .body {
                                        EnvironmentValueLabel(value: ".dark", mode: .used)
                                    }
                            }
                            .body {
                                EnvironmentValueLabel(value: ".dark")
                            }
                            Tree("Heart", id: "heart24")
                                .body {
                                    EnvironmentValueLabel(value: ".dark", mode: .used)
                                }
                        }
                        .body {
                            EnvironmentValueLabel(value: ".dark")
                        }
                    }
                    .body {
                        EnvironmentValueLabel(value: ".dark", mode: .rewritten)
                    }
                }.showIf(episode, at: Episode("e06-02"))

                Panel.renderTree("Поддерево") {
                    Tree(".environment") {
                        Tree("VStack") {
                            Tree("Heart", id: "heart21")
                                .body {
                                    EnvironmentValueLabel(value: ".dark", mode: .used)
                                }
                            Tree(".environment", id: "environment2") {
                                Tree("HStack") {
                                    Tree("Heart", id: "heart22")
                                        .body {
                                            EnvironmentValueLabel(value: ".light", mode: .used)
                                        }
                                    Tree("Heart", id: "heart23")
                                        .body {
                                            EnvironmentValueLabel(value: ".light", mode: .used)
                                        }
                                }
                                .body {
                                    EnvironmentValueLabel(value: ".light")
                                }
                            }.body {
                                EnvironmentValueLabel(value: ".light", mode: .rewritten)
                            }
                            Tree("Heart", id: "heart24")
                                .body {
                                    EnvironmentValueLabel(value: ".dark", mode: .used)
                                }
                        }
                        .body {
                            EnvironmentValueLabel(value: ".dark")
                        }
                    }
                    .body {
                        EnvironmentValueLabel(value: ".dark", mode: .rewritten)
                    }
                }.showIf(episode, after: Episode("e06-03"))

                Panel.preview {
                    VStack {
                        EnvironmentExample()
                        HStack {
                            EnvironmentExample()
                            EnvironmentExample()
                        }
                        .environment(
                            \.colorTheme, (Episode("e06-02")...Episode("e06-02")).contains(episode)
                                ? .dark : .light
                        )
                        EnvironmentExample()
                    }
                    .environment(\.colorTheme, episode >= Episode("e06-02") ? .dark : .light)
                }
            }
        }

        var heartParams: String {
            if episode >= e02 {
                ""
            } else {
                "theme: theme"
            }
        }
    }
}
