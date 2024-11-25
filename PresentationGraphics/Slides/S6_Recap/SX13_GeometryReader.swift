//
//  SX4_State.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 25.11.2024.
//

import SwiftUI

struct SX13_GeometryReader: View, Slide {
    let section: Int

    var id: String {
        "S\(section)13_GeometryReader"
    }

    var episodes: [Episode] {
        e00 {
            "⚠️ Важная идея - geometry reader"
        }
    }

    var body: some View {
        ImportantLayout("Размер вью мы можем прочитать через GeometryReader") {
        }
    }
}
