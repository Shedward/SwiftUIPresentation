//
//  S30_Animations.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

struct S43_UnitGeometry: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - Еще раз немного про эту unit-геометрию для нагладности
            - Раньше мы описывали положение подвьюх через их левые верхний угол и высоту
            """
        )

        e01(
            """
            - Теперь мы это описываем через положение и относительное положение крепления
            - Это из-за того что теперь вьюха сама отвечает за свой размер
            """
        )

        e02(
            """
            - В рамках тупых аналогий можно представить что frame'ом мы прибивали вьюху гвоздями по 4ем углам
            - При работе с анкором - теперь мы ставим кронштейм на который можно повесить вьюху любого размера
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "Unit-геометрия") {
            Panels {
                Panel("Frame") {
                    if episode < e02 {
                        Image(.frame00)
                    } else {
                        Image(.frame01)
                    }
                }
                Panel("Anchor") {
                    if episode < e02 {
                        Image(.anchor00)
                    } else {
                        SpacedHStack {
                            Image(.anchor01)
                            Image(.anchor02)
                            Image(.anchor03)
                        }
                    }
                }.showIf(episode, after: e01)
            }
        }
    }
}
