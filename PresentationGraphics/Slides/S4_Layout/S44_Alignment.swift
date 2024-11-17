//
//  S30_Animations.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

struct S44_Alignment: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - Теперь немного про AlignmentGuide'ы
            - По сути каждая вьюха предоставляет пачку гайдов
            - Каждый гайд определяет какое-то семантическое место во вьюхе
            - Контейнеры используют гайды чтобы выравнивать вьюхи внутри себя
            - Дефолтные гайды это leading/trailing/top/bottom
            - И дополнительно связанные с текстом - firstTextBaseline/lastTextBaseline
            - Для примера:
            """
        )

        Episode("e01-00", notes: "- top")
        Episode("e01-01", notes: "- firstTextBaseline")
        Episode("e01-02", notes: "- center")
        Episode("e01-03", notes: "- lastTextBaseline")
        Episode("e01-04", notes: "- bottom")

        e02(
            """
            - Еще мы можем изменить гайд у любой вьюхи с помощью модификатора `alignmentGuide`
            """
        )

        e03(
            """
            - Или создать вообще свой кастомный гайд
            - Прописывается похожим образом как преференсы
            - И использовать его в кастомных коллекциях 
            - Или кастомных лайаутах
            """
        )
        e04("- Например применим в стеке")
    }

    var alignment: VerticalAlignment {
        switch episode {
        case Episode("e01-00"): .top
        case Episode("e01-01"): .firstTextBaseline
        case Episode("e01-02"): .center
        case Episode("e01-03"): .lastTextBaseline
        case Episode("e01-04"): .bottom
        case e04: .custom
        default:
            .bottom
        }
    }

    var alignmentDescription: String {
        switch alignment {
            case .top: ".top"
            case .firstTextBaseline: ".firstTextBaseline"
            case .center: ".center"
            case .lastTextBaseline: ".lastTextBaseline"
            case .bottom: ".bottom"
            case .custom: ".custom"
            default: "\(alignment.key)"
        }
    }

    var body: some View {
        TitleSubtitleLayout(title: "AlignmentGuide") {
            Panels {
                Panel.code("CustomGuide") {
                    """
                    struct CustomAlignment: AlignmentID {
                        static func defaultValue(
                            in context: ViewDimensions
                        ) -> CGFloat {
                            0.75 * context.height - 16
                        }
                    }

                    extension VerticalAlignment {
                        static let custom 
                            = VerticalAlignment(CustomAlignment.self)
                    }

                    extension Alignment {
                        static let leadingCustom 
                            = Alignment(horizontal: .leading, vertical: .custom)
                    }
                    """
                }.showIf(episode, after: e03)

                Panel.code {
                    "HStack(alignment: \(alignmentDescription)) {"
                        .highlight(episode == e04)

                    """
                        Text("Several lines\\n of text")
                        Image(systemName: "text.below.photo")
                        VStack {
                            Text("up")
                            Image(systemName: "arrow.up.and.down")
                            Text("down")
                        }
                    """
                    """
                        .alignmentGuide(.bottom) { size in
                            size.width * 0.5
                        }
                    """.showIf(episode, at: e02)
                    """
                    }
                    """
                }
                Panel.preview {
                    HStack(alignment: alignment) {
                        Text("Several lines\n of text")
                        Image(systemName: "text.below.photo")
                        VStack {
                            Text("up")
                            Image(systemName: "arrow.up.and.down")
                            Text("down")
                        }
                        .if(episode == e02) {
                            $0.alignmentGuide(.bottom) { size in
                                 size.width * 0.5
                            }
                        }
                    }
                }
            }
        }
    }
}

struct CustomAlignment: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        0.75 * context.height - 16
    }
}

extension VerticalAlignment {
    static let custom = VerticalAlignment(CustomAlignment.self)
}

extension Alignment {
    static let leadingCustom = Alignment(horizontal: .leading, vertical: .custom)
}
