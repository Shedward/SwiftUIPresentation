//
//  S30_Animations.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

struct S48_Anchors: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "Anchors") {
            Panels {
            }
        }
    }
}
