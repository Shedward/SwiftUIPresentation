//
//  S02_Plan.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//

import SwiftUI

struct S02_Plan: View, Slide {
    var body: some View {
        ListLayout(title: "0.2 План", subtitle: "О чем расскажу", style: .enumerated) {
            "Структура"
            "Состояния"
            "Анимации"
            "Потоки данных"
            "Лайаут"
        }
    }
}

#Preview {
    S02_Plan()
}
