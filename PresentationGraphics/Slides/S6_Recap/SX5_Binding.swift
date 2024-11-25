//
//  SX5_Binding.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 25.11.2024.
//

import SwiftUI

struct SX5_Binding: View, Slide {
    let section: Int

    var id: String {
        "S\(section)5_Binding"
    }

    var episodes: [Episode] {
        e00 {
            "⚠️ Важная идея - Binding"
        }
    }

    var body: some View {
        ImportantLayout("Binding - для внешних состояний которые мы хотим изменять изнутри") {
            "Геттер и сеттер"
            "Текущее значение приходит извне"
            "Изменяем мы значение в какой-то внешней модели"
            "Не владеет состоянием"
        }
    }
}
