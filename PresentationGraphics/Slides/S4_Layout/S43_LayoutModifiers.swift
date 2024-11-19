//
//  S30_Animations.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

struct S43_LayoutModifiers: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - Напрямую с Layout вы сталкиваться будете совсем не часто
            - Но вы постоянно сталкиваетесь с модификаторами
            - которые влияют на лайаут вьюх
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "Модификаторы") {
            Table(
                header: Table.Header("Модификатор", "ProposedViewSize", "sizeThatFits"),
                alignment: .leading
            ) {
                Table.Row {
                    Table.Cell {
                        ModifierDescription(
                            code: ".padding",
                            description: "Добавляет отступы"
                        )
                    }
                    Table.Cell.code {
                        "width: parentWidth - insets"
                        "height: parentHeight - insets"
                    }
                    Table.Cell.code {
                        "width: subviewWidth + insets"
                        "height: subviewHeight + insets"
                    }
                }

                Table.Row {
                    Table.Cell {
                        ModifierDescription(
                            code: ".fixedSize()",
                            description: "Игнорирует пропоузал"
                        )
                    }
                    Table.Cell.code {
                        "width: nil"
                        "height: nil"
                    }
                    Table.Cell.code {
                        "width: subviewWidth"
                        "height: subviewHeight"
                    }
                }

                Table.Row {
                    Table.Cell {
                        ModifierDescription(
                            code: ".frame(width: 100, height: 100)",
                            description: "Игнорирует и пропоузал и размер"
                        )
                    }
                    Table.Cell.code {
                        "width: 100"
                        "height: 100"
                    }
                    Table.Cell.code {
                        "width: 100"
                        "height: 100"
                    }
                }

                Table.Row {
                    Table.Cell {
                        ModifierDescription(
                            code: ".frame(min:max:ideal)",
                            description: "Принимает пропоузал с ограничениями"
                        )
                    }
                    Table.Cell.code {
                        "width: (parentWidth ?? idealWidth)"
                        "   .clamp(minWidth, maxWidth)"
                    }
                    Table.Cell.code {
                        "width: (parentWidth ?? idealWidth)"
                        "    .clamp(minWidth, maxWidth)"
                        "    ?? subviewWidth"
                    }
                }

                Table.Row {
                    Table.Cell {
                        ModifierDescription(
                            code: ".aspectRatio(4/3, mode: .fit)",
                            description: "Вырезает место по пропорции"
                        )
                    }
                    Table.Cell.code {
                        "parentSize.frame(aspect: 4/3, mode: .fit)"
                    }
                    Table.Cell.code {
                        "subviewSize"
                    }
                }
            }
        }
    }
}

struct ModifierDescription: View {
    let code: String
    let description: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(code)
                .style(.codeSmall)
            Text(description)
                .style(.caption)
        }
    }
}
