//
//  S11_View.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 17.10.2024.
//

import SwiftUI

struct S11_View: View, Slide {

    @Environment(\.step)
    var step: String

    var body: some View {
        TitleSubtitleLayout(
            title: "View Trees",
            subtitle: "Вьюхи это деревья"
        ) {
            Panels {
                Panel("Код") {
                    CodeView {
                        """
                        HStack {
                            Image(systemName: "house")
                            Text("Hello")
                                .padding()
                        }
                        """
                    }
                }
                if step >= "e01_ShowViewTree" {
                    Panel("View Tree") {
                        TreeView(
                            tree: Tree("HStack") {
                                Tree("Image")
                                Tree(".padding") {
                                    Tree("Text")
                                }
                            }
                        )
                    }
                }
                Panel("Preview") {
                    HStack {
                        Image(systemName: "house")
                        Text("Hello")
                            .padding()
                    }
                    .bordered()
                }
            }
        }
    }

    var steps: [Step] {
        "e01_ShowViewTree"
    }
}
