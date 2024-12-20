//
//  S01_TestSlide.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//

import SwiftUI

struct ComplexMockSlide: View, Slide {
    var body: some View {
        TitleSubtitleLayout(
            title: "Определение RenderTree",
            subtitle: "Что это такое?"
        ) {
            Panels {
                Panel.code {
                    """
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
                    """
                }
                Panel("RenderTree") {
                    TreeView(
                        Tree("ContentView") {
                            Tree("Panels") {
                                Tree("Panel(\"Код\")") {
                                    Tree("CodeView")
                                }
                                Tree("Panel(\"Панель 2\")") {
                                    Tree("Text")
                                }
                            }
                        }
                    )
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
    ComplexMockSlide()
}
