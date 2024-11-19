//
//  S30_Animations.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

struct S45_GeometryReader4: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - Еще один - получение размера вьюхи и передача его куда-то 
            - Мы можем получить как 
            - В светлом будущем (iOS 17) у нас будет отдельный модификатор для этого onGeometryChange 
            """
        )

        e01(
            """
            - Кроме получения размера мы так же можем получить полноценный фрейм с положением
            - Причем получить мы его можем в локальном пространстве координат, в глобальном
            """
        )

        e02(
            """
            - Или даже в кастомном
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "GeometryReader", subtitle: "Нарисовать что-то поверх") {
            Panels {
                Panel.code {
                    """
                    public struct UpdateBySize: ViewModifier {
                         
                        @State
                        var size: CGSize = .zero
                         
                        public func body(content: Content) -> some View {
                            content
                                .overlay {
                                    GeometryReader { proxy in
                    """
                    "                   let size = proxy.size"
                            .highlight(episode == e00)
                    showIf(episode, after: e01) {
                        "                   let frame = proxy.frame(in: .local)"
                            .highlight(episode == e01)
                        "                   let globalFrame = proxy.frame(in: .global)"
                            .highlight(episode == e01)
                    }
                    showIf(episode, at: e02) {
                        "                   let frameInStack = proxy.frame(in: .named(\"MyCoordSpace\"))"
                            .highlight(episode == e02)
                    }
                    """
                                        Color.clear
                                            .onAppearOrChange(of: size) {
                                                self.size = size
                                            }
                                    }
                                }
                            }
                        }
                    }
                    """
                }

                Panel.code("Обозначаем CoordinateSpace") {
                    """
                    public struct Content: View {
                        VStack {
                            Text("Title")
                            Text("Subtitle")
                            HStack {
                                Image(name: "icon")
                                UpdateBySize()
                            }
                    """
                    """
                            .coordinateSpace(name: "MyCoordSpace")
                    """
                        .highlight()
                    """
                        }
                    }
                    """
                }
                .showIf(episode, at: e02)
            }
        }
    }
}
