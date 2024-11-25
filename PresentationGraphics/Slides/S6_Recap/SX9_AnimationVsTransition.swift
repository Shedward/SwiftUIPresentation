//
//  SX4_State.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 25.11.2024.
//

import SwiftUI

struct SX9_AnimationVsTransition: View, Slide {
    let section: Int

    var id: String {
        "S\(section)8_AnimationVsTransaction"
    }

    var episodes: [Episode] {
        e00 {
            "⚠️ Важная идея - Анимации - изменение, Транзишн - появление/удаление"
        }
    }

    var body: some View {
        ImportantLayout("Анимации - изменение, Транзишн - появление/удаление") {
        }
    }
}
