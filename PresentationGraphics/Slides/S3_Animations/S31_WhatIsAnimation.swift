//
//  S31_WhatIsAnimation.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI
import Charts
import QuartzCore

struct S31_WhatIsAnimation: View, Slide {

    @Environment(\.space)
    var space: Space

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - Вспомним сначала что определяет анимацию
            """
        )

        e01(
            """
            - Во первых у нас есть некое изменяющееся значение
            - Допустим это положение по x оси на экране
            - Задающее с какого на какое значение у нас должно изменится при анимации
            - Важный момент - это значение должно быть интерполируемым
            - Т.е. зная произвольный прогресс мы должны мочь посчитать значение между началом и концом
            """
        )

        e02(
            """
            - Затем у нас есть длительность анимации
            - В настоящих секундах
            - Которая задает собственно сколько анимация будет длиться
            """
        )

        e03(
            """
            - И еще у нас есть тайминг функция 
            - Это произвольная функция. 
            - Обратите внимание что она мапит значения от 0 до 1 на другие значение от 0 до 1
            - Она задает форму изменения анимации
            """
        )

        e04(
            """
            - Соединяя все вместе мы получаем анимацию
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "Анимации", subtitle: "Что это такое") {
            HStack {
                Panels {
                    Panel("Изменяемое значение") {
                        Chart {
                            RuleMark(yStart: .value("from", 50), yEnd: .value("to", 100))
                            PointMark(y: .value("from", 50))
                                .symbol(.square)
                            PointMark(y: .value("to", 100))
                                .symbol(.triangle)
                        }
                        .chartYAxisLabel("CGFloat")
                        .chartYScale(domain: 0...150)
                        .fixedSize()
                    }.showIf(episode, after: e01)

                    Panel("Время анимации") {
                        Chart {
                            RuleMark(xStart: .value("start", 0), xEnd: .value("end", 0.250))

                            PointMark(x: .value("start", 0))
                                .symbol(.square)
                            PointMark(x: .value("end", 0.250))
                                .symbol(.square)
                        }
                        .chartXAxisLabel("сек.")
                        .fixedSize()
                    }.showIf(episode, after: e02)

                    Panel("Тайминг функция") {
                        Chart {
                            LinePlot(x: "x", y: "y") { x in easeInOut(x) }
                        }
                        .chartXScale(domain: 0...1)
                        .chartYScale(domain: 0...1)
                        .fixedSize()
                    }.showIf(episode, after: e03)
                }

                showIf(episode, after: e04) {
                    Text("=")
                        .style(.body)
                        .frame(width: 2.0 * space.innerValue())
                    
                    Panels {
                        Panel("Анимация") {
                            Chart {
                                LinePlot(x: "time", y: "value") { x in
                                    guard (0...0.250).contains(x) else { return .nan }
                                    return 50 * easeInOut(x / 0.250) + 50
                                }
                            }
                            .chartXScale(domain: 0...0.3)
                            .chartYScale(domain: 0...150)
                            .chartYAxisLabel("CGFloat")
                            .chartXAxisLabel("сек.")
                            .frame(height: 150)
                            .fixedSize()
                        }
                    }
                }
            }
        }
    }
}

func easeInOut(_ x: Double) -> Double {
    return x < 0.5 ? 2 * x * x : -2 * (x - 1) * (x - 1) + 1
}
