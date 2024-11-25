//
//  S17_ViewBuilderIsNotACode.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 20.10.2024.
//

import SwiftUI

struct S18_RenderTree5: View, Slide {

    var episodes: [Episode] {
        e00 {
            "Затем SwiftUI применит этот диф"
            "<описать инфу на экране>"
        }
    }

    var body: some View {
        TitleSubtitleLayout(title: "Render Tree", subtitle: "Применяем diff") {
            Panels {
                Panel("Добавление", background: DiffKind.added.color.opacity(0.3)) {
                    BulletList {
                        "Если есть .transiton(), тогда происходит анимация появления"
                        "Вызывает onAppear()"
                        "Добавит ноды в AttributedGraph"
                        "Показывает элемент на экране"
                    }
                }

                Panel("Изменение", background: DiffKind.changed.color.opacity(0.3)) {
                    BulletList {
                        "Если есть .animation() на изменившиеся поля - происходит анимация изменения"
                        "Вызовет .onChange() на изменившиеся поля"
                        "Обновляет изменившиеся поля"
                    }
                }

                Panel("Удаление", background: DiffKind.removed.color.opacity(0.3)) {
                    BulletList {
                        "Вызывает onDisappear()"
                        "Если есть .transiton(), тогда происходит анимация исчезновения"
                        "Удаляет ноды из AttributedGraph"
                        "Убирает элемент с экрана"
                    }
                }
            }
        }
    }
}
