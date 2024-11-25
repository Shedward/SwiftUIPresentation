//
//  SX4_State.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 25.11.2024.
//

import SwiftUI

struct SX10_LayoutIsNegotiation: View, Slide {
    let section: Int

    var id: String {
        "S\(section)10_LayoutIsNegotiation"
    }

    var episodes: [Episode] {
        e00 {
            "⚠️ Важная идея - Лайаут это переговоры"
        }
    }

    var body: some View {
        ImportantLayout("Размер определяется в переговорах") {
            "- Размер предлагается родителем"
            "- Размер нельзя навязать чайлду"
        }
    }
}
