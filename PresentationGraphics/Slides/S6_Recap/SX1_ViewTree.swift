//
//  S61_ViewTree.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 25.11.2024.
//

import SwiftUI

struct SX1_ViewTree: View, Slide {
    let section: Int

    var id: String {
        "S\(section)1_ViewTree"
    }

    var episodes: [Episode] {
        e00 {
            "⚠️ Важная идея - View Tree"
        }
    }

    var body: some View {
        ImportantLayout("ViewTree") {
            "Структура body"
            "Не код - а древовидная структура"
            "Статично"
            "Представляет все возможные состояния"
        }
    }
}
