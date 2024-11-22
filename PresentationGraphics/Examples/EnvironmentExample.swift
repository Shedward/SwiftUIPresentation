//
//  EnvironmentExample.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 20.11.2024.
//

import SwiftUI

struct ColorTheme {
    let content: Color
    let background: Color

    static let light = ColorTheme(content: .black, background: .white)
    static let dark = ColorTheme(content: .white, background: .black)
}

enum ColorThemeKey: EnvironmentKey {
    static let defaultValue: ColorTheme = .light
}

extension EnvironmentValues {
    var colorTheme: ColorTheme {
        get { self[ColorThemeKey.self] }
        set { self[ColorThemeKey.self] = newValue }
    }
}

struct EnvironmentExample: View {
    @Environment(\.colorTheme)
    var colorTheme: ColorTheme

    var body: some View {
        Text("♥")
            .foregroundColor(colorTheme.content)
            .background(colorTheme.background)
    }
}

#Preview {
    VStack {
        EnvironmentExample()
        HStack {
            EnvironmentExample()
            EnvironmentExample()
        }
        HStack {
            EnvironmentExample()
        }
    }
}
