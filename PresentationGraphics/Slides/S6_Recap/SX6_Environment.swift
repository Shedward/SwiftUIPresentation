//
//  SX4_State.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 25.11.2024.
//

import SwiftUI

struct SX6_Environment: View, Slide {
    let section: Int

    var id: String {
        "S\(section)6_Environment"
    }

    var episodes: [Episode] {
        e00 {
            "⚠️ Важная идея - Environment"
        }
    }

    var body: some View {
        ImportantLayout("Environment - для прокидывание данных вниз по дереву") {
        }
    }
}
