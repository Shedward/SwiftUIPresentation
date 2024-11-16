//
//  S30_Animations.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

struct S41_LayoutLogic2: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - С iOS 16 мы можем влезть в этот процесс напрямую если реализуем протокол Layout
            - Минимальная реализация его выглядит вот так
            - Мы обязаны заимплементить два метода 
            - sizeThatFits который высчитывает размер
            - placeSubviews который раскидывает вьюхи
            - В этом протоколе мы оперируем двумя интересными моделями
            """
        )

        e01(
            """
            - Первая это ProposedViewSize
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "Layout", subtitle: "Протокол") {
            Panels {
                Panel.code("Layout") {
                    """
                    struct CustomLayout: Layout {
                        func sizeThatFits(
                            proposal: ProposedViewSize,
                            subviews: Subviews,
                            cache: inout ()
                        ) -> CGSize {
                            ...
                        }
                         
                        func placeSubviews(
                            in bounds: CGRect,
                            proposal: ProposedViewSize,
                            subviews: Subviews,
                            cache: inout ()
                        ) {
                            ...
                        }
                    }
                    """
                }
            }
        }
    }
}
