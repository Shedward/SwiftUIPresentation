//
//  S30_Animations.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

struct S45_GeometryReader2: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - Один из самых стандартных способов использования 
            - Верстка динамически зависящая от размеров контейнера
            - Например две колонки
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "GeometryReader", subtitle: "Лайаут по ширине") {
            Panels {
                Panel.code {
                    """
                    public struct TwoColumn<Content: View>: View {

                        let spacing: CGFloat = 16
                        let content: () -> Content
                         
                        init(@ViewBuilder content: @escaping () -> Content) {
                            self.content = content
                        }
                         
                        public var body: some View {
                            GeometryReader { proxy in
                                let width = proxy.width
                                ZStack(alignment: .topLeading) {
                                    content()
                                        .frame(width: 0.5 * (width - spacing))
                                    content()
                                        .frame(width: 0.5 * (width - spacing))
                                        .offset(x: 0.5 * width + spacing)
                                }
                            }
                        }
                    }
                    """
                }

                Panel.preview {
                    TwoColumn {
                        Rectangle()
                    }
                }
            }
        }
    }
}
