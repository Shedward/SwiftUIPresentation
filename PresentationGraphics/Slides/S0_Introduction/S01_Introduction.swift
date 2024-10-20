//
//  S01_Introduction.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//

import SwiftUI

struct S01_Introduction: View, Slide {

    var body: some View {
        ListLayout(title: "Для кого", subtitle: "Для чего") {
            "Узнаете матчасть SwiftUI"
            "Сможете пройти наш собес"
            "Для тех кому в падлу читать книжку"
        }
    }
}

#Preview {
    S01_Introduction()
}
