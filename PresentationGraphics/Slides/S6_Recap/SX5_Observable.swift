//
//  SX4_State.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 25.11.2024.
//

import SwiftUI

struct SX5_Observable: View, Slide {
    let section: Int

    var id: String {
        "S\(section)5_Observable"
    }

    var episodes: [Episode] {
        e00 {
            "⚠️ Важная идея - Observable"
        }
    }

    var body: some View {
        ImportantLayout("Observable - для объектов") {
            "Для референс объектов"
            "Изменятся может и внутри и извне"
            "Может приходить откуда угодно"
            "Подписывается только на использованных изменения полей"
            "Перерисовывает вью только на изменение использованных полей"
        }
    }
}
