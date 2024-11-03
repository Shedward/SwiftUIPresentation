//
//  S21_StateModifier4.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 02.11.2024.
//

import SwiftUI

struct S21_StateModifier5: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var body: some View {
        Important("@State - только для внутренних состояний. Приходит изнутри, изменяется внутри. Владеет состоянием")
    }
}
