//
//  S17_ViewBuilderIsNotACode.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 20.10.2024.
//

import SwiftUI

struct S18_RenderTree5: View, Slide {

    @Environment(\.episode)
    var episode: String

    var notes: String? {
        """
        e00 - Затем SwiftUI применит этот диф
        """
    }

    var body: some View {
        TitleSubtitleLayout(title: "Render Tree", subtitle: "Применяем diff") {
            Panels {
                Panel("Добавление", background: DiffKind.added.color.opacity(0.3)) {
                    PointsList {
                        "Добавляет элемент на экран"
                        "Если есть .transiton(), тогда происходит анимация появления"
                        "Вызывает onAppear()"
                    }
                }

                Panel("Изменение", background: DiffKind.changed.color.opacity(0.3)) {
                    PointsList {
                        "Обновляет изменившиеся поля"
                        "Если есть .animation() на изменившиеся поля - происходит анимация изменения"
                    }
                }

                Panel("Удаление", background: DiffKind.removed.color.opacity(0.3)) {
                    PointsList {
                        "Вызывает onDisappear()"
                        "Если есть .transiton(), тогда происходит анимация исчезновения"
                        "Удаляет элемент с экрана"
                    }
                }
            }
        }
    }
}
