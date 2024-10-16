//
//  S13_ViewBuilder.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 17.10.2024.
//

import SwiftUI

struct S13_ViewBuilder: View, Slide {

    @Environment(\.episode)
    var episodes: String

    var body: some View {
        TitleSubtitleLayout(title: "View Builder", subtitle: "Что такое TuppleView") {
            Panels {
                Panel.code {
                    """
                    VStack {
                        Image(systemName: "house")
                        Text("Hello")
                        Image(systemName: "hand.wave")
                    }
                    """
                }

                Panel.preview {
                    VStack {
                        Image(systemName: "house")
                        Text("Hello")
                        Image(systemName: "hand.wave")
                    }
                }
            }
        }
    }
}

#Preview {
    S13_ViewBuilder()
}
