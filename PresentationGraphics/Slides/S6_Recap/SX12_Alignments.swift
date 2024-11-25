//
//  SX4_State.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 25.11.2024.
//

import SwiftUI

struct SX12_Alignments: View, Slide {
    let section: Int

    var id: String {
        "S\(section)12_Alignments"
    }

    var episodes: [Episode] {
        e00 {
            "⚠️ Важная идея - алайменты"
        }
    }

    var body: some View {
        ImportantLayout("Вью предоставляет свои алайменты") {
        }
    }
}
