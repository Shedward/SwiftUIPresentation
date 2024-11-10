//
//  S34_ImplicitExplicit.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 09.11.2024.
//

import SwiftUI

struct S34_ImplicitExplicit3: View, Slide {

    var episodes: [Episode] {
        e00(
            """
            - 
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "Анимация по биндингу") {
            Panels {
                Panel.code {
                    """
                    struct ToggleRectangle: View {
                        @Binding var flag: Bool
                        var body: some View {
                            Rectangle()
                                .frame(width: flag ? 100 : 50, height: 50)
                                .onTapGesture { flag.toggle() }
                        }
                    }
                     
                    struct ContentView: View {
                        @State private var flag = false
                        var body: some View {
                    """
                    "        ToggleRectangle(flag: flag.animation(.default))"
                        .highlight()
                    """
                        }
                    }
                    """
                }

                Panel.code("Смысл") {
                    """
                    struct ToggleRectangle: View {
                        @Binding var flag: Bool
                        var body: some View {
                            Rectangle()
                                .frame(width: flag ? 100 : 50, height: 50)
                                .onTapGesture { 
                                    withAnimation {
                                        flag.toggle() 
                                    }
                                }
                        }
                    }
                    """
                }
            }
        }
    }
}
