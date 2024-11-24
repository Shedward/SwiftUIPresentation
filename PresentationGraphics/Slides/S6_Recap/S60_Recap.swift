//
//  S30_Animations.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

struct S60_Recap: View, Slide {

    var episodes: [Episode] {
        e00 {
            "Повторим самые важные идеи"
        }
    }

    var body: some View {
        SectionTitleLayout(text: "Повторим важное")
    }
}
