//
//  S11_ViewTrees.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//


import SwiftUI

struct S11_ViewTrees: View, Slide {
    var body: some View {
        TitleSubtitleLayout(title: "View Trees") {
            Panels {
                Panel("Код") {
                    CodeView("""
                        Text("Hello")
                            .padding()
                            .background(Color.blue)
                        """)
                }
                Panel("Preview") {
                    Text("Hello")
                        .padding()
                        .background(Color.blue)
                }
                Panel("View Tree") {
                    TreeView(tree: Tree(".background") {
                        Tree(".padding") {
                            Tree("Text")
                        }
                        Tree("Color")
                    })
                }
            }
        }
    }
}

#Preview {
    S11_ViewTrees()
}
