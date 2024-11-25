//
//  SX4_State.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 25.11.2024.
//

import SwiftUI

struct SX11_LayoutPositioning: View, Slide {
    let section: Int

    var id: String {
        "S\(section)11_LayoutPositioning"
    }

    var episodes: [Episode] {
        e00 {
            "⚠️ Важная идея - Когда размеры известны, вьюхи по иерархии начинают располагать свои подвьюхи"
        }
    }

    var body: some View {
        ImportantLayout("Когда размеры известны - родитель располагает своих детей") {
            "При этом свой размер дети все равно определяют сами"
        }
    }
}
