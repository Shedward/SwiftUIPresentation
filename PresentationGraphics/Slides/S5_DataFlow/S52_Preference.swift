//
//  S30_Animations.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

struct S52_Preference: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "Preferences") {
            Panels {
            }
        }
    }
}