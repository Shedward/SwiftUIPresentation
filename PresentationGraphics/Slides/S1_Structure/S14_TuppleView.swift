//
//  S14_TuppleView.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 19.10.2024.
//

import SwiftUI

struct S14_TuppleView: View, Slide {

    @Environment(\.episode)
    var episode: String

    var episodes: [Episode] {
        "e01-tupple-view"
        "e02-комбинация-туплов"
        "e03-тупл-над-туплами"
        "e04-схлопывание-туплов"
    }

    var notes: String? {
        """
        e00 - Вынесем тело VStack'а в отдельную переменную
            - Как видим, мы и в переменной можем написать несколько вьюх
        e01 - Оказывается, var content на самом деле возвращает TuppleView<(Image,Text,Image)>
            - TuppleView один из самых базовых кирпичиков в SwiftUI
            - Любой список вьюх во ViewBuilder'е это TuppleView
        e02 - Более того, мы можем скормить VStack'у - еще один tupple
            - И VStack объеденит контент этих двух туплов
        e03 - И справедливости ради на самом деле тут есть еще один тупл
            - И вообще любое использования @ViewBuild'ер а создает тупл
        e04 - Но в независимости от вложенности - туплы вложенные в туплы семантически схлопываются в один список
        """
    }

    var contentTuppleViewHightlihgt: Color? {
        episode == "e01-tupple-view"
            ? Theme.Color.highlight
            : nil
    }

    var body: some View {
        TitleSubtitleLayout(title: "TuppleView") {
            Panels {
                Panel.code {
                    "var body: some View {"
                    "    VStack {"
                    "        content"
                    "        content2"
                        .showIf(episode, after: "e02-комбинация-туплов")
                    "    }"
                    "}"
                    
                    """
                        
                    @ViewBuilder
                    """

                    """
                    var content: some View {
                    """
                        .hideIf(episode, after: "e01-tupple-view")

                    """
                    var content: TuppleView<(Image, Text, Image)> {
                    """
                        .showIf(episode, after: "e01-tupple-view")?
                        .highlight(contentTuppleViewHightlihgt)

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
                    """.showIf(episode, after: "e02-комбинация-туплов")
                }

                Panel.viewTree {
                    if episode < "e02-комбинация-туплов" {
                        Tree("VStack") {
                            Tree(
                                episode >= "e01-tupple-view"
                                    ? "TuppleView"
                                    : "...",
                                id: "content-tupple",
                                highlight: contentTuppleViewHightlihgt
                            ) {
                                Tree("Image", id: "home-image")
                                Tree("Text", id: "hello-text")
                                Tree("Image", id: "wave-image")
                            }
                        }
                    } else if episode < "e03-тупл-над-туплами" {
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
                    } else if episode < "e04-схлопывание-туплов" {
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
                            }
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
                        showIf(episode, after: "e02-комбинация-туплов") {
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
