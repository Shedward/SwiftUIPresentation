//
//  S30_Animations.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

struct S45_GeometryReader: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - Еще один из самых полезных инструментов верстки является GeometryReader
            """
        )

        e01(
            """
            - Семантически это просто вьюха которая занимает все предложенное пространство
            - И сообщает своим подвьюхам свой размер
            - НО - чайлды не учавствуют в расчете размера GeometryReader'а
            - Он принимает любой предложенный
            - По своей сути GeometryReader нам нужен там где нам нужно знать размер вьюхи в дереве
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "GeometryReader") {
            Panels {
                Panel.code {
                    """
                    public struct GeometryReaderExample: View {
                        public var body: some View {
                            GeometryReader { proxy in
                                Text("\\(proxy.size)")
                            }
                        }
                    }
                    """
                }

                Panel.preview {
                    GeometryReaderExample()
                }.showIf(episode, at: e01)
            }
        }
    }
}
