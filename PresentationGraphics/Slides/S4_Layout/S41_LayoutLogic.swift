//
//  S30_Animations.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

struct S31_LayoutLogic: View, Slide {

    var body: some View {
        TitleSubtitleLayout(title: "Layout", subtitle: "Логика") {
            Panels {
                Panel.code {
                    """
                    Text("Favorite")
                        .padding(10)
                        .background(Color.teal)
                    """
                }

                Panel.renderTree {
                    Tree("Background") {
                        Tree("Padding") {
                            Tree("Text")
                        }
                        Tree("Color")
                    }
                }
            }
        }
    }
}
