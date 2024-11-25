//
//  SX4_State.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 25.11.2024.
//

import SwiftUI

struct SX7_Preference: View, Slide {
    let section: Int

    var id: String {
        "S\(section)6_Preference"
    }

    var episodes: [Episode] {
        e00 {
            "⚠️ Важная идея - Preference"
        }
    }

    var body: some View {
        ImportantLayout("Preference - для прокидывание данных вверх по дереву") {
        }
    }
}
