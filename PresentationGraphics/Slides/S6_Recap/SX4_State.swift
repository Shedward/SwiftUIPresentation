//
//  SX4_State.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 25.11.2024.
//

import SwiftUI

struct SX4_State: View, Slide {
    let section: Int

    var id: String {
        "S\(section)4_State"
    }

    var episodes: [Episode] {
        e00 {
            "⚠️ Важная идея - State"
        }
    }

    var body: some View {
        ImportantLayout("State - только для внутренних состояний") {
            "Изначальное значение может приходить извне"
            "Нельзя изменить извне"
            "Можно изменить только изнутри"
            "Вью сама владеет этим состоянием"
        }
    }
}
