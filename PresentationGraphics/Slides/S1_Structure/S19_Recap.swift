//
//  S17_ViewBuilderIsNotACode.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 20.10.2024.
//

import SwiftUI

struct S19_Recap: View, Slide {

    var body: some View {
        TitleSubtitleLayout(title: "Структура") {
            Panels {
                Panel("View Tree") {
                    PointsList {
                        "То что в var body"
                        "Дерево подвьюх"
                        "Описывает View во всех состояниях"
                        "@ViewBuilder - сахар чтобы конструировать его в виде кода"
                        "Каждое выражение в @ViewBuilder остается вьюхой"
                        "Структура кода полностью отражается в типе структуры"
                        "Положение вьюхи в дереве - идентифицирует вьюху"
                    }
                }

                Panel("Render Tree") {
                    PointsList {
                        "View Tree + Состояние = Render Tree"
                        "SwiftUI вычисляет Render Tree при каждом изменении состояния"
                        "SwiftUI сравнивает новое Render Tree с текущим и строит разницу"
                        "Эта разница определяет как будет обновляться UI"
                    }
                }
            }
        }
    }
}
