//
//  S17_ViewBuilderIsNotACode.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 20.10.2024.
//

import SwiftUI

struct S17_ViewBuilderDSL: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00 {
            "Соберем все вместе"
            "Теперь мы знаем что каждый экспрешн превращается во вьюху"
            "Поэтому тело body и любого ViewBuilder'а это не код в привычном нам понимании"
            "Это конструктор древовидной структуры"
        }
        e01 {
            "Т.е. когда мы смотрим на тело вьюхи"
            "На самом деле это хитрый конструктор который ВЫГЛЯДИТ КАК КОД"
            "Поэтому в этом коде положение и структура имеет значение"
            "Поэтому вещи одинаковые по смыслу в обычном коде - тут будут иметь разное поведение"
        }
    }

    var body: some View {
        TitleSubtitleLayout(title: "Что такое ViewBuilder", subtitle: "Не код, а DSL") {
            switch episode {
            case e00:
                e00_body
            case e01:
                e01_body
            default:
                EmptyView()
            }
        }
    }

    @ViewBuilder
    var e00_body: some View {
        Table(
            header: Table.Header("", "Код", "Смысл", "type(of: body)"),
            alignment: .leading
        ) {
            Table.Row {
                Table.Cell {
                    Text("Выражения")
                        .style(.caption)
                }
                Table.Cell.code {
                    """
                    FirstView()
                    SecondView()
                    ThirdView()
                    """
                }
                Table.Cell.code {
                    """
                    TuppleView(
                        FirstView()
                        SecondView()
                        ThirdView()
                    )
                    """
                }
                Table.Cell.code {
                    """
                    TuppleView<(
                        FirstView,
                        SecondView,
                        ThirdView
                    )>
                    """
                }
            }

            Table.Row {
                Table.Cell {
                    Text("Условия")
                        .style(.caption)
                }
                Table.Cell.code {
                    """
                    if test {
                        TrueView()
                    } else {
                        FalseView()
                    }
                    """
                }
                Table.Cell.code {
                    """
                    _ConditionalContent(
                        condition,
                        TrueView(),
                        FalseView()
                    )
                    """
                }
                Table.Cell.code {
                    """
                    _ConditionalContent<
                        TrueView,
                        FalseView
                    >
                    """
                }
            }

            Table.Row {
                Table.Cell {
                    Text("Опциональность")
                        .style(.caption)
                }
                Table.Cell.code {
                    """
                    if test {
                        TrueView()
                    }
                    
                    if let optional {
                        ContentView(optional)
                    }
                    """
                }
                Table.Cell.code {
                    """
                    test ? TrueView() : nil
                    optional.map { ContentView($0) }
                    """
                }
                Table.Cell.code {
                    """
                    Optional<TrueView>
                    """
                }
            }

            Table.Row {
                Table.Cell {
                    Text("Циклы")
                        .style(.caption)
                }
                Table.Cell.code {
                    """
                    ForEach(data) { dataItem in
                        CellView(dataItem)
                    }
                    """
                }
                Table.Cell.code {
                    """
                    ForEach(data) { dataItem in
                        CellView(dataItem)
                    }
                    """
                }
                Table.Cell.code {
                    """
                    ForEach<Data, DataId, Cell>
                    """
                }
            }

            Table.Row {
                Table.Cell {
                    Text("Пустое выражение")
                        .style(.caption)
                }
                Table.Cell.code {
                    """
                     
                    """
                }
                Table.Cell.code {
                    """
                    EmptyView()
                    """
                }
                Table.Cell.code {
                    """
                    EmptyView
                    """
                }
            }
        }
        .reduceSpacing()
    }

    @ViewBuilder
    var e01_body: some View {
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
