//
//  S21_StateModifier.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 30.10.2024.
//

import SwiftUI

struct S21_StateModifier: View, Slide {

    var episodes: [Episode] {
        e00(
            """
            - Начнем с самого базового варианта хранения состояния, модификатора @State
            """
        )
    }

    @State
    var count: Int = 0

    var body: some View {
        TitleSubtitleLayout(
            title: "@State",
            subtitle: "Внутреннее состояние"
        ) {
            Panels {
                Panel.code {
                """
                struct Counter: View {
                    @State
                    var count: Int = 0
                    
                    var body: some View {
                        HStack {
                            Text("\\(count)")
                            Button("minus") {
                                count -= 1
                            }
                            Button("plus") {
                                count += 1
                            }
                        }
                    }
                }
                """
                }

                Panel.viewTree {
                    Tree("Counter") {
                        Tree("HStack") {
                            Tree("Text")
                            Tree("Button", id: "minus-button")
                            Tree("Button", id: "plus-button")
                        }
                    }.body {
                        InitialStateLabel(name: "count", initialValue: "0")
                    }
                }

                Panel.renderTree {
                    Tree("Counter") {
                        Tree("HStack") {
                            Tree("Text")
                                .caption("\(count)")
                            Tree("Button", id: "minus-button")
                                .caption("-")
                            Tree("Button", id: "plus-button")
                                .caption("+")
                        }
                    }.body {
                        CurrentStateLabel(name: "count", initialValue: "\(count)")
                    }
                }

                Panel.preview {
                    Counter(count: $count)
                }
            }
        }
    }
}
