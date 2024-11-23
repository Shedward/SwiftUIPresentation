//
//  S30_Animations.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

struct S52_Preference2: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - Еще добавлю пару слов про reduce
            - Мы его использовали тут по минимуму для смешения величин
            - Но то как мы этот метод определим определяет поведение преференса
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "Preferences", subtitle: "reduce") {
            Table(header: .init("reduce", "Поведение", "Пример")) {
                Table.Row {
                    Table.Cell.code {
                        """
                        .preference(Key.self, size)
                        ...
                        let value: CGSize = nextValue()
                        """
                    }

                    Table.Cell {
                        Text("Передаем ровно одну величину")
                            .style(.body)
                    }

                    Table.Cell {
                        Text("Чтение размера контейнера")
                            .style(.body)
                    }
                }

                Table.Row {
                    Table.Cell.code {
                        """
                        .preference(Key.self, unreadCount)
                        ...
                        let value: Int = value + nextValue()
                        """
                    }

                    Table.Cell {
                        Text("Собираем сумму некой величины")
                            .style(.body)
                    }

                    Table.Cell {
                        Text("Общий счетчик")
                            .style(.body)
                    }
                }

                Table.Row {
                    Table.Cell.code {
                        """
                        .preference(Key.self, [annotation])
                        ...
                        value: [Annotation] = value + nextValue()
                        """
                    }

                    Table.Cell {
                        Text("Собираем список всех моделей")
                            .style(.body)
                    }

                    Table.Cell {
                        Text("Отрисовать поверх анотации со всех элементов")
                            .style(.body)
                    }
                }

                Table.Row {
                    Table.Cell.code {
                        """
                        .preference(Key.self, ["timingCurve": .easeIn])
                        .preference(Key.self, ["duration": 8])
                        ...
                        value: [String: Any] = value.merged(with: nextValue())
                        """
                    }

                    Table.Cell {
                        Text("Собираем более сложную модель")
                            .style(.body)
                    }

                    Table.Cell {
                        Text("🤷")
                            .style(.body)
                    }
                }
            }
        }
    }
}
