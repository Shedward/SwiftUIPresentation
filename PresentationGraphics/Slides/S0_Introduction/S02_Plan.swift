//
//  S02_Plan.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//

import SwiftUI

struct S02_Plan: View, Slide {

    var episodes: [Episode] {
        e00 {
            "План на сегодня такой"
        }
    }

    var body: some View {
        ListLayout(title: "План", subtitle: "О чем расскажу", style: .enumerated) {
            "Структура"
            "Состояние"
            "Потоки данных"
            "Анимации"
            "Лайаут"
        }
    }
}

#Preview {
    S02_Plan()
}
