//
//  S17_ViewBuilderIsNotACode.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 20.10.2024.
//

import SwiftUI

struct S17_ViewBuilderDSL: View, Slide {

    @Environment(\.episode)
    var episode: String

    var episodes: [Episode] {
        "e01-код-это-дерево"
    }

    var notes: String? {
        """
        e00 - Мы знаем ViewBuilder по сути превращает выражения в коде в древовидные структуры
            - Поэтому тело body и любого ViewBuilder'а это не код в привычном нам понимании
        e01 - Тело ViewBuilder'а это описание дерева которое ВЫГЛЯДИТ КАК КОД
            - Поэтому в нем положение и структура каждого элемента имеют важное значение
            - Поэтому вещи одинаковые по смыслу в обычном коде - тут будут иметь разное поведение 
        """
    }

    var body: some View {
        TitleSubtitleLayout(title: "ViewBuilder это DSL") {
            switch episode {
            case "e00":
                e00
            case "e01-код-это-дерево":
                e01
            default:
                EmptyView()
            }
        }
    }

    @ViewBuilder
    var e00: some View {
        Table(
            header: Table.Header("", "Как мы пишем", "Как бы мы писали\n без @ViewBuilder"),
            alignment: .leading
        ) {
            Table.Row {
                Table.Cell {
                    Text("Выражения")
                        .style(.caption)
                }
                Table.Cell {
                    CodeView {
                        """
                        FirstView()
                        SecondView()
                        ThirdView()
                        """
                    }
                    .framed(fill: Theme.Color.backgroundSecondary)
                }
                Table.Cell {
                    CodeView {
                        """
                        TuppleView(
                            FirstView(),
                            SecondView(),
                            ThirdView()
                        )
                        """
                    }
                    .framed(fill: Theme.Color.backgroundSecondary)
                }
            }

            Table.Row {
                Table.Cell {
                    Text("Условия")
                        .style(.caption)
                }
                Table.Cell {
                    CodeView {
                        """
                        if test {
                            TrueView()
                        } else {
                            FalseView()
                        }
                        """
                    }
                    .framed(fill: Theme.Color.backgroundSecondary)
                }
                Table.Cell {
                    CodeView {
                        """
                        _ConditionalContent(
                            TrueView(),
                            FalseView()
                        )
                        """
                    }
                    .framed(fill: Theme.Color.backgroundSecondary)
                }
            }

            Table.Row {
                Table.Cell {
                    Text("Циклы")
                        .style(.caption)
                }
                Table.Cell {
                    CodeView {
                        """
                        ForEach(data) { dataItem in
                            CellView(dataItem)
                        }
                        """
                    }
                    .framed(fill: Theme.Color.backgroundSecondary)
                }
                Table.Cell {
                    CodeView {
                        """
                        ForEach(data) { dataItem in
                            CellView(dataItem)
                        }
                        """
                    }
                    .framed(fill: Theme.Color.backgroundSecondary)
                }
            }
        }
    }

    @ViewBuilder
    var e01: some View {
        Panels {
            Panel.code("C DSL") {
                """
                @ViewBuilder
                var body: some View {
                    VStack {
                        if let avatar {
                            AvatarView(user.avatar)
                        }
                        
                        let name = user.fullName.name
                        Text(name)
                
                        switch user.status {
                            case .online: 
                                OnlineBadge()
                            case .offline:
                                OfflineBadge()
                        }
                
                        HStack {
                            ForEach(user.achievements) {
                                AchievementView($0)
                            }
                            LockedAchievementsCounter()
                        }
                    }
                }
                """
            }

            Panel.code("Без DSL") {
                """
                @NotViewBuilder
                var body: some View {
                    VStack(
                        TuppleView(
                            user.avatar.map { unwrapped in
                                AvatarView(unwrapped)
                            },
                            Text(user.fullName.name)
                            _ConditionalContent(
                                user.status,
                                OnlineBadge(),
                                OfflineBadge()
                            ),
                            HStack(
                                TuppleView(
                                    ForEach(user.achievements) {
                                        AchievementView($0)
                                    },
                                LockedAchievementsCounter()
                            )
                        )
                    )
                }
                """
            }
        }
    }
}
