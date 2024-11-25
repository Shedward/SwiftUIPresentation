//
//  SX4_State.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 25.11.2024.
//

import SwiftUI

struct SX8_AnimationByTransaction: View, Slide {
    let section: Int

    var id: String {
        "S\(section)8_AnimationByTransaction"
    }

    var episodes: [Episode] {
        e00 {
            "⚠️ Важная идея - Анимации через транзакции"
        }
    }

    var body: some View {
        ImportantLayout("Анимации происходят через транзакции") {
        }
    }
}
