//
//  S61_ViewTree.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 25.11.2024.
//

import SwiftUI

struct SX3_RenderTree: View, Slide {
    let section: Int

    var id: String {
        "S\(section)2_RenderTree"
    }

    var episodes: [Episode] {
        e00 {
            "⚠️ Важная идея - Render Tree"
        }
    }

    var body: some View {
        ImportantLayout("RenderTree") {
            "AttributedGraph"
            "ViewTree + состояние"
            "Изменяется при изменении состояния"
            "Определяет что будет отрисовано на экране"
            "Построенная по плану вьюха"
        }
    }
}
