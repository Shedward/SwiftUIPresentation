//
//  S01_TestSlide.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//

import SwiftUI

struct S99_TestSlide: View, Slide {
    var body: some View {
        TitleSubtitleLayout(
            title: "Определение RenderTree",
            subtitle: "Что это такое?"
        ) {
            Panels {
                Panel("Код") {
                    CodeView("""
                    struct ContentView: View {

                        var body: some View {
                            SlideView(
                                title: "Определение RenderTree",
                                subtitle: "Что это такое?"
                            ) {
                                Panels {
                                    Panel("Код") {
                                        CodeView(\"""
                                        HStack {
                                            Text("Title")
                                            Text("Subtitle")
                                        }
                                        \""")
                                    }
                                    Panel("Панель 2") {
                                        Text("Панель 2")
                                    }
                                }
                            }
                        }
                    }
                    """)
                }
                Panel("RenderTree") {
                    TreeView(tree: Tree("ContentView") {
                        Tree("Panels") {
                            Tree("Panel(\"Код\")") {
                                Tree("CodeView")
                            }
                            Tree("Panel(\"Панель 2\")") {
                                Tree("Text")
                            }
                        }
                    })
                }
                Panel("Результат") {
                    Rectangle()
                        .foregroundStyle(.clear)
                }
            }
        }
    }
}

#Preview {
    S99_TestSlide()
}
