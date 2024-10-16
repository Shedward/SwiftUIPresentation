//
//  S11_ViewTrees.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//


import SwiftUI

struct S11_ViewTrees: View, Slide {

    @Environment(\.step)
    var step: String

    var showPadding: Bool {
        step < "02_RemovePadding"
    }

    var body: some View {
        TitleSubtitleLayout(title: "View Trees") {
            Panels {
                Panel("Код") {
                    CodeView {
                        "Text(\"Hello\")"
                        if showPadding {
                            "    .padding()"
                                .highlight(.yellow)
                        }
                        "    .background(Color.blue)"
                    }
                }
                if step >= "01_ShowViewTree" {
                    Panel("View Tree") {
                        TreeView(tree: Tree(".background") {
                            if showPadding {
                                Tree(".padding") {
                                    Tree("Text")
                                }
                            }
                            Tree("Color")
                        })
                    }
                }
                Panel("Preview") {
                    Text("Hello")
                        .if(showPadding) {
                            $0.padding()
                        }
                        .background(Color.blue)
                }
            }
            .animation(.snappy, value: step)
        }
    }

    var steps: [Step] {
        "01_ShowViewTree"
        "02_RemovePadding"
    }
}

#Preview {
    S11_ViewTrees()
}
