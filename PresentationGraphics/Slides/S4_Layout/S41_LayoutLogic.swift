//
//  S30_Animations.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

struct S41_LayoutLogic: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - Давайте теперь посмотрим как вьюхи определяют свои размеры и расположения относительно друг друга
            - Если в UIKit'е у нас были констрейнты где мы задавали взаимоотношения вьюх правилами
            - В SwiftUI совсем другая система
            - Тут вьюхи договариваются между собой
            """
        )
        e01(
            """
            - Давайте сначала посмотрим на пример этих переговоров в простом случае
            """
        )

        e02(
            """
            - Сначала Container предлагает Padding размер
            """
        )

        e03(
            """
            - Padding вычитает свои отступы и спрашивает дочерний контент - предлагая ему оставшееся место
            """
        )

        e04(
            """
            - Контент смотрит на предложенные размеры и говорит что для таких размеров его устраивает (60, 90)
            """
        )

        e05(
            """
            - Падинг берет размер своего чайлда, добавляет отступы и возвращает своему контейнеру (70, 100)
            """
        )

        e06(
            """
            - Root размещает Padding внутри себя, допустим по центру
            """
        )

        e07(
            """
            - Padding размещает внутри себя Content учитывая отступы
            """
        )

        e08(
            """
            - И по полученным фреймам вьюхи отрисовываются
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "Layout", subtitle: "Логика") {
            Panels {
                Panel.bullets("Алгоритм") {
                    "Допустим Root - корневая вьюха с заданным размером"
                    "Root предлагает Padding доступный размер".showIf(episode, after: e02)
                    "Padding может спросить размеры Content".showIf(episode, after: e03)
                    "Content возвращает Padding свой размер".showIf(episode, after: e04)
                    "Padding возвращает Root свой размер".showIf(episode, after: e05)
                    "Root зная размер, размещает Padding".showIf(episode, after: e06)
                    "Padding зная размер, размещает Content".showIf(episode, after: e07)
                }
                .showIf(episode, after: e01)

                Panel.renderTree {
                    Tree("Root") {
                        Tree("Padding") {
                            Tree("Content")
                                .annotationId("content")
                                .body {
                                    ShowIf(after: e07) {
                                        LayoutFrame(
                                            size: CGSize(width: 70, height: 100),
                                            position: CGPoint(x: 15, y: 0)
                                        )
                                    }
                                }
                        }
                        .annotationId("padding")
                        .body {
                            ShowIf(after: e06) {
                                LayoutFrame(
                                    size: CGSize(width: 60, height: 90),
                                    position: CGPoint(x: 25, y: 10)
                                )
                            }
                        }
                    }
                    .annotationId("root")
                    .body {
                        LayoutFrame(
                            size: CGSize(width: 100, height: 100),
                            position: .zero
                        )
                    }
                }

                Panel.preview {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 60, height: 90)
                        .padding(10)
                        .frame(width: 100, height: 100)
                }
                .showIf(episode, at: e08)
            }
            .annotate {
                TextAnnotation(to: "root", message: "(100, 100)?")
                    .parentProposeKind()
                    .showIf(episode, at: e02)
                TextAnnotation(to: "padding", message: "(90, 90)?")
                    .parentProposeKind()
                    .showIf(episode, at: e03)
                TextAnnotation(to: "content", message: "(60, 90)!")
                    .childResponseKind()
                    .showIf(episode, in: e04...e06)
                TextAnnotation(to: "padding", message: "(70, 100)!")
                    .childResponseKind()
                    .showIf(episode, at: e05)
            }
        }
    }
}
