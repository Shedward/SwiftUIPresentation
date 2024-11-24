//
//  S14_TuppleView.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 19.10.2024.
//

import SwiftUI

struct S14_TuppleView: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00 {
            "Мы можем вынести тело в отдельную переменную с @ViewBuilder"
            "И так же в самой переменной написать несколько вьюх"
        }
        e01 {
            "И если мы раскроем тип у этой переменной окажется что это TuppleView<(Image,Text,Image)>"
            "TuppleView один из самых базовых кирпичиков в SwiftUI"
            "Любой список вьюх это TuppleView"
        }
        e02 {
            "Мы даже можем скормить стеку второй VStack"
            "И VStack объединит контент двух туплов"
        }
        e03 {
            "Справедливости ради еще один тупл есть в теле самого VStack"
        }
        e04 {
            "Но в независимости от вложености - вложенные туплы семантически схлопываются в один"
            "Поэтому в дальнейшем я не буду рисовать"
            "Само ветвление в дереве - подразумевается что тут тупл"
        }
    }

    var body: some View {
        TitleSubtitleLayout(title: "Список", subtitle: "Перечисление вьюх") {
            Panels {
                Panel.code {
                    "var body: some View {"
                    "    VStack {"
                        .highlight(episode == e03)
                    "        content"
                    "        content2"
                        .showIf(episode, after: e02)
                    "    }"
                    "}"
                    
                    """
                        
                    @ViewBuilder
                    """

                    """
                    var content: some View {
                    """
                        .hideIf(episode, after: e01)

                    """
                    var content: TuppleView<(Image, Text, Image)> {
                    """
                        .showIf(episode, after: e01)?
                        .highlight(episode == e01)

                    """
                        Image(systemName: "house")
                        Text("Hello")
                        Image(systemName: "hand.wave")
                    }    
                    """

                    """
                        
                    @ViewBuilder
                    var content2: TuppleView<(Text, Image)> {
                        Text("World")
                        Image(systemName: "globe")
                    }  
                    """.showIf(episode, after: e02)
                }

                Panel.viewTree {
                    if episode < e02 {
                        Tree("VStack") {
                            Tree(
                                episode >= e01
                                    ? "TuppleView"
                                    : "...",
                                id: "content-tupple"
                            ) {
                                Tree("Image", id: "home-image")
                                Tree("Text", id: "hello-text")
                                Tree("Image", id: "wave-image")
                            }
                            .highlight(episode == e01)
                        }
                    } else if episode < e03 {
                        Tree("VStack") {
                            Tree("TuppleView", id: "content-tupple") {
                                Tree("Image", id: "home-image")
                                Tree("Text", id: "hello-text")
                                Tree("Image", id: "wave-image")
                            }
                            Tree("TuppleView", id: "content2-tupple") {
                                Tree("Text", id: "world-text")
                                Tree("Image", id: "globe-image")
                            }
                        }
                    } else if episode < e04 {
                        Tree("VStack") {
                            Tree("TuppleView", id: "vstack-tupple") {
                                Tree("TuppleView", id: "content-tupple") {
                                    Tree("Image", id: "home-image")
                                    Tree("Text", id: "hello-text")
                                    Tree("Image", id: "wave-image")
                                }
                                Tree("TuppleView", id: "content2-tupple") {
                                    Tree("Text", id: "world-text")
                                    Tree("Image", id: "globe-image")
                                }
                            }.highlight(episode == e03)
                        }
                    } else {
                        Tree("VStack") {
                            Tree("Image", id: "home-image")
                            Tree("Text", id: "hello-text")
                            Tree("Image", id: "wave-image")
                            Tree("Text", id: "world-text")
                            Tree("Image", id: "globe-image")
                        }
                    }
                }

                Panel.preview {
                    VStack {
                        Group {
                            Image(systemName: "house")
                            Text("Hello")
                            Image(systemName: "hand.wave")
                        }
                        showIf(episode, after: e02) {
                            Group {
                                Text("World")
                                Image(systemName: "globe")
                            }
                        }
                    }
                }
            }
        }
    }
}
