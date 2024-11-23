//
//  S30_Animations.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

struct S52_Preference: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - Как данные передавать вглубь разобрались
            - Теперь рассмотрим ситуацию наоборот когда нужно пробрасывать данные наверх.
            - Допустим у нас есть некая вьюха с несколькими яркими цветными пятнами
            - К нам пришел дизайнер и сказал - фон не очень, хотим чтобы фон ячейки зависел от контента
            - Хотим чтобы фон брал тинт от смеси цветов этих ярких пятен
            """
        )

        e01(
            """
            - Для этого нам сперва как с Environment 
            - нужно определить ключ по которому будем хранить значение
            - У него тоже должно быть дефолтное значение
            - И еще обязательно нужно указать метод reduce,
            - Этот метод нужен для того чтобы определять 
            - Как нам собирать значения чайлдов и идя вверх по дереву
            - Пока укажем тут что цвета у нас должны смешиваться в один
            """
        )

        e02(
            """
            - Затем нам нужно как-то отправить данные от чайлдов.
            - Для этого есть модификатор .preference(key:value)
            """
        )

        e03(
            """
            - Для удобства завернем сразу в хелпер
            """
        )

        e04(
            """
            - Затем нам нужно где-то поймать собранные результаты
            - Для этого у нас есть модификатор .onPreferenceChanged
            """
        )

        e05(
            """
            - И используем модификатор на нашем коде
            - И цвета смешаются
            """
        )

        e06(
            """
            - Причем мы можем этот модификатор использовать и на подвьюхах 
            - И изменяя значения 
            """
        )

        e07(
            """
            - Давайте теперь на дереве посмотрим как это выглядит
            - чтобы лучше понять механику
            - У нас есть несколько нод отправляющих значения 
            - И несколько нод слушающих
            - 
            - До полного прогона по дереву preference'ы нам не известны
            - Чтобы их узнать нужно сперва собрать полное дерево рендеринга 
            """
        )

        Episode("e07-00", notes: "- Вернем еще реализацию")
        Episode("e07-01", notes: "- В процессе рендеринга дерева каждый .preference сообщают свои предпочтения")
        Episode(
            "e07-02",
            notes:
                """
                - Когда все дерево пройдено, ноды onPreferenceChange собирает все записаные предпочтения
                - И применяет к получившемуся списку нашу функцию reduce
                - Над VStack собирает свои
                """
        )

        Episode(
            "e07-03",
            notes: "- Над HStack собирает свои"
        )

        Episode(
            "e07-04",
            notes:
            """
            - Затем модификатор обновляет свой стейт
            - И все подвьюхи перерисовываются
            """
        )

        Episode(
            "e07-05",
            notes:
            """
            - Обратите внимание что для того чтобы вычислить предпочтения нам пришлось пройтись по дереву два раза
            - Таких проходов может быть и больше если собранный преференс может повлиять на преференсы чайлдов
            - поэтому нужно быть аккуратным чтобы не вляпаться в бесконечную перерисовку
            """
        )

        Episode(
            "e07-06",
            notes:
            """
            - Помимо этого, преференс может зависить от внутреннего состояния вьюхи
            - И если это состояние поменяется (по клику например)
            """
        )

        Episode(
            "e07-07",
            notes:
            """
            - То все подписаные на ключ родители будут об этом уведомлены
            """
        )

        Episode(
            "e07-08",
            notes:
            """
            - И вьюхи снова перерисуются
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "Preferences") {
            Panels {
                Panel.code("Отправка", font: Theme.Font.codeExtraSmall) {
                    """
                    struct MixingKey: PreferenceKey {
                        static let defaultValue: Color? = nil

                        static func reduce(
                            value: inout Color?, 
                            nextValue: () -> Color?
                        ) {
                            value = value.mix(nextValue())
                        }
                    }
                    """

                    """
                     
                    extension View {
                        func mixingBackground(_ color: Color?) -> some View {
                            self
                                .background(color ?? .clear)
                                .preference(
                                    key: MixingKey.self, 
                                    value: color
                                )
                        }
                    }
                    """.showIf(episode, after: e03)
                }
                .showIf(
                    (e01...e03).contains(episode)
                    || (Episode("e07-00")...Episode("e07-99")).contains(episode)
                )

                Panel.renderTree(font: Theme.Font.bodySmall) {
                    Tree(".mixedBackground", id: "mixedBackground1") {
                        Tree("HStack") {
                            Tree(".mixedBackground", id: "mixingBackground1") {
                                Tree("VStack") {
                                    Tree(".mixing", id: "mixing(.white)") {
                                        Tree("Box", id: "box2")
                                    }
                                    .annotatable("mixing(.white)")
                                    Tree(".mixing", id: ".mixing(.red)") {
                                        Tree("Box", id: "box3")
                                    }
                                    .annotatable("mixing(.red)")
                                }
                            }
                            .annotatable("mixedInner")
                            Tree(".mixing", id: ".mixing(.blue)") {
                                Tree("Box", id: "box1")
                            }
                            .annotatable("mixing(.blue)")
                        }
                    }
                    .annotatable("mixedOuter")
                    .annotate {
                        showIf(episode, in: Episode("e07-01")...Episode("e07-04")) {
                            TextAnnotation(to: "mixing(.white)", message: ".white")
                                .childResponseKind()
                            TextAnnotation(to: "mixing(.red)", message: ".red")
                                .childResponseKind()
                                .position(.halfTopTrailing)
                            TextAnnotation(to: "mixing(.blue)", message: ".blue")
                                .childResponseKind()
                                .position(.halfTopTrailing)
                        }

                        showIf(episode, in: Episode("e07-02")...Episode("e07-03")) {
                            TextAnnotation(to: "mixedInner", message: ".white.mix(.red)")
                                .parentProposeKind()
                                .position(.bottom)
                        }

                        showIf(episode, at: Episode("e07-03")) {
                            TextAnnotation(to: "mixedOuter", message: ".white.mix(.red).mix(.blue)")
                                .parentProposeKind()
                                .position(.bottom)
                        }

                        showIf(episode, at: Episode("e07-04")) {
                            TextAnnotation(to: "mixedInner", message: "mixedColor = <pink>")
                                .parentProposeKind()
                                .position(.bottom)
                            TextAnnotation(to: "mixedOuter", message: "mixedColor = <purple>")
                                .parentProposeKind()
                                .position(.bottom)
                        }

                        showIf(episode, at: Episode("e07-05")) {
                            TextAnnotation(to: "mixedInner", message: "background(<pink>)")
                                .parentProposeKind()
                                .position(.bottom)
                            TextAnnotation(to: "mixedOuter", message: "background(<purple>)")
                                .parentProposeKind()
                                .position(.bottom)
                        }

                        showIf(episode, at: Episode("e07-06")) {
                            TextAnnotation(to: "mixing(.blue)", message: "state = .yellow")
                                .childResponseKind()
                                .position(.top)
                        }

                        showIf(episode, at: Episode("e07-07")) {
                            TextAnnotation(to: "mixedOuter", message: "mixedColor = <orange>")
                                .parentProposeKind()
                                .position(.bottom)
                        }

                        showIf(episode, at: Episode("e07-08")) {
                            TextAnnotation(to: "mixedInner", message: "background(<pink>)")
                                .parentProposeKind()
                                .position(.bottom)
                            TextAnnotation(to: "mixedOuter", message: "background(<orange>)")
                                .parentProposeKind()
                                .position(.bottom)
                        }
                    }
                }
                .showIf(episode, after: e07)

                Panel.code("Получение", font: Theme.Font.codeExtraSmall) {
                    """
                    struct MixedBackgroundModifier: ViewModifier {
                         
                        @State
                        private var mixedColor: Color = .clear
                         
                        func body(content: Content) -> some View {
                            content
                    """
                    """
                                .onPreferenceChange(MixingKey.self) { 
                                    mixedColor in
                                     
                                    self.mixedColor 
                                      = mixedColor ?? .clear
                                }
                    """
                        .highlight(episode == e04)
                    """
                                .background(mixedColor.opacity(0.5))
                        }
                    }
                     
                    extension View {
                        func mixedBackground() -> some View {
                            modifier(MixedBackgroundModifier())
                        }
                    }
                    """
                }
                .showIf(
                    (e04...e06).contains(episode)
                    || (Episode("e07-00")...Episode("e07-99")).contains(episode)
                )

                Panel.code("Контент") {
                    "    HStack {"
                    "        VStack {"
                    "            Box(100)"
                    "                .background(.white)"
                    """
                                    .preference(
                                        key: MixingKey.self, 
                                        value: .white
                                    )
                    """
                        .showIf(episode, at: e02)?
                        .highlight(episode == e02)
                    "                .mixingBackground(.white)"
                        .showIf(episode, after: e03)
                    "            Box(100)"
                    "                .background(.red)"
                    """
                                    .preference(
                                        key: MixingKey.self, 
                                        value: .red
                                    )
                    """
                        .showIf(episode, at: e02)?
                        .highlight(episode == e02)
                    "                .mixingBackground(.red)"
                        .showIf(episode, after: e03)
                    "        }"
                    "        .mixedBackground()"
                        .showIf(episode, after: e06)?
                        .highlight(episode == e06)
                    "        Box(100)"
                    "            .background(.blue)"
                    """
                                .preference(
                                    key: MixingKey.self, 
                                    value: .blue
                                )
                    """
                        .showIf(episode, at: e02)?
                        .highlight(episode == e02)
                    "            .mixingBackground(.blue)"
                        .showIf(episode, after: e03)
                    "    }"
                    "    .background(.gray)"
                        .hideIf(episode, after: e05)
                    "    .mixedBackground()"
                        .showIf(episode, after: e05)?
                        .highlight(episode == e05)
                }
                .hideIf(episode, after: Episode("e07-00"))

                Panel.preview("Превью") {
                    HStack {
                        VStack {
                            MixingBox(.white)
                            MixingBox(.red)
                        }
                        .if(episode >= e06) {
                            $0.mixedBackground()
                        }
                        MixingBox(.blue)
                    }
                    .if(episode >= e05) {
                        $0.mixedBackground()
                    } else: {
                        $0.padding(8)
                            .background(.gray)
                    }
                }
                .hideIf(episode, after: Episode("e07-00"))
            }
        }
    }
}

struct MixingBox: View {
    @State
    private var colorIndex: Int = -1

    let initialColor: Color
    let colors: [Color] = [.red, .orange, .yellow, .green, .teal, .blue, .purple]

    var selectedColor: Color {
        if colors.indices.contains(colorIndex % colors.count) {
            colors[colorIndex % colors.count]
        } else {
            initialColor
        }
    }

    init(_ initialColor: Color) {
        self.initialColor = initialColor
    }

    var body: some View {
        Box(100)
            .mixingBackground(selectedColor)
            .onTapGesture {
                withAnimation {
                    colorIndex += 1
                }
            }
    }
}
