//
//  S30_Animations.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

struct S44_Alignment2: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - Немного подробнее про природу Alignment в SwiftUI
            - Мы наверное привыкли с UIKit'а что алаймент это некий энамчик который как 
            - В SwiftUI это не так 
            - В SwiftUI alignment это динамическая величина
            - Это функция от размера которую можно переопределить
            - Даже базовые алайменты определены так
            - У нас есть структура Vertical и HorizontalAliment, 
            - которые по сути являются ключом для значения.
            - Можете представить что у вьюхи есть словарь с алайментами
            """
        )

        e01(
            """
            - Кастомные вписываются в эту картину
            - И задаются как те же энвайроменты, объявив отдельный ключ и дефолтное поведение
            """
        )

        e02(
            """
            - А переопределить мы можем любой алаймент
            - Хоть наш, хоть существующий
            - По сути мы заменяем одну функцию расчета на другую по ключу в словаре
            """
        )

        e03(
            """
            - Еще вы могли заметить что у нас есть вертикальный и горизонтальный
            - Но нету двухмерного алаймента для ZStack например
            - Он на самом деле определяется из горизонтального и вертикального
            - И так же мы можем собрать кастомный
            - Про алайменты все
            """
        )

        e04(
            """
            - И на стороне использования. В лайауте. 
            - Мы можем как спросить у вьюхи любой алаймент
            - Использовать его для позиционирования вьюхи
            - Так и рассчитать свои собственные для всей коллекции и передать их родителю
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "AlignmentGuide") {
            Panels {
                Panel.code(font: Theme.Font.codeExtraSmall) {
                    """
                    extension VerticalAlignment {
                    """
                    """
                        private enum TopAlignment: AlignmentID {
                            static func defaultValue(in context: ViewDimensions) -> CGFloat {
                                0
                            }
                        }
                         
                        static let top = VerticalAlignment(TopAlignment.self) 
                         
                        private enum BottomAlignment: AlignmentID {
                            static func defaultValue(in context: ViewDimensions) -> CGFloat {
                                context.height
                            }
                        }
                         
                        static let bottom = VerticalAlignment(BottomAlignment.self) 
                    """
                        .collapseIf(episode: episode, after: e01)

                    """
                        private enum CustomAlignment: AlignmentID {
                            static func defaultValue(in context: ViewDimensions) -> CGFloat {
                                0.75 * context.height - 16
                            }
                        }

                        static let customAlignment = VerticalAlignment(CustomAlignment.self)
                    """
                        .showIf(episode, after: e01)
                    """
                    }
                     
                    extension HorizontalAlignment {
                    """
                    """
                        private enum LeadingAlignment: AlignmentID {
                            static func defaultValue(in context: ViewDimensions) -> CGFloat {
                                0
                            }
                        }
                         
                        static let leading = VerticalAlignment(LeadingAlignment.self) 
                         
                        private enum TrailingAlignment: AlignmentID {
                            static func defaultValue(in context: ViewDimensions) -> CGFloat {
                                context.width
                            }
                        }
                         
                        static let trailing = VerticalAlignment(TrailingAlignment.self)
                    """
                        .collapseIf(episode: episode, after: e01)
                    """
                    }
                    """

                    """
                     
                    struct CustomView: View {
                        var body: some Body {
                            HStack(alignment: .top) {
                                Text("Hello")
                                    .alignmentGuide(.top) { context in
                                        context.height * 0.20
                                    }
                            }
                        }
                    }
                    """
                        .showIf(episode, after: e02)

                    """
                     
                    extension Alignment {
                        public static let top = Alignment(horizontal: .center, vertical: .top)
                        public static let center = Alignment(horizontal: .center, vertical: .center)
                        public static let bottom = Alignment(horizontal: .center, vertical: .bottom)
                        public static let topLeading = Alignment(horizontal: .leading, vertical: .top)

                        public static let customLeading
                            = Alignment(horizontal: .leading, vertical: .customAlignment)
                    }  
                    """
                        .showIf(episode, after: e03)
                }

                Panel("Alignment") {
                    if episode == e00 {
                        Image(.alignments)
                    } else if episode == e01 {
                        Image(.alignmentsCustom)
                    } else if episode == e02 {
                        Image(.alignmentsModified)
                    } else if episode == e03 {
                        Image(.alignments2D)
                    }
                }
                .hideIf(episode, after: e04)

                Panel.code("Layout") {
                    """
                    struct CustomLayout: Layout {
                        let alignment: VerticalAlignment
                         
                        func sizeThatFits(
                            proposal: ProposedViewSize,
                            subviews: Subviews
                        ) -> CGSize {
                            var size: CGSize = .zero
                         
                            subviews.forEach { subview in
                                let positionAdjustment =
                                    subview.dimensions(in: proposal)[alignment]

                                // Как-то считаем размеры с учетом алаймента
                            }
                        }
                         
                        func placeSubviews(
                            in bounds: CGRect,
                            proposal: ProposedViewSize,
                            subviews: Subviews
                        ) {
                            subviews.forEach { subview in
                                let positionAdjustment =
                                    subview.dimensions(in: proposal)[alignment]

                                // Как-то распологаем вьюхи учетом алаймента
                            }
                        }
                         
                        func explicitAlignment(
                            of guide: HorizontalAlignment,
                            in bounds: CGRect,
                            proposal: ProposedViewSize,
                            subviews: Subviews
                        ) -> CGFloat? {
                            // Тут можем вернуть кастомное значение алаймента
                            // если нужно
                        }
                    }
                    """
                }
                .showIf(episode, at: e04)
            }
        }
    }
}
