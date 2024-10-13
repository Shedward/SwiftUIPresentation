//
//  Theme.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 09.10.2024.
//

import SwiftUI

enum Theme {
    enum Font {
        static let h1 = SwiftUI.Font.custom("Helvetica Neue Bold", size: 80)
        static let h2 = SwiftUI.Font.custom("Helvetica Neue Bold", size: 40)
        static let body = SwiftUI.Font.custom("Helvetica Neue", size: 18)
        static let code = SwiftUI.Font.custom("JetBrains Mono", size: 18)
        static let caption = SwiftUI.Font.custom("Helvetica Nueue", size: 16)
    }

    enum Color {
        static let backgroundPrimary = SwiftUI.Color(hex: 0xffffff)
        static let backgroundSecondary = SwiftUI.Color(hex: 0xfafafc)
        static let contentPrimary = SwiftUI.Color(hex: 0x000000)
        static let contentSecondary = SwiftUI.Color(hex: 0x808080)
        static let contentTertiary = SwiftUI.Color(hex: 0xd2d2d7)
        static let tintPrimary = SwiftUI.Color(hex: 0x0066cc)
        static let tintSecondary = SwiftUI.Color(hex: 0xff610d)
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 8) {
        Text("RenderTree (Attribute Graph)")
            .font(Theme.Font.h1)
        Text("Что такое RenderTree, как оно получается от View Tree")
            .font(Theme.Font.h2)
        Text("""
            SwiftUI uses the view tree to construct a persistent render tree. View trees themselves
            are ephemeral: we like to think of view trees as blueprints, since they get constructed
            and then thrown away over and over again.
            """)
            .font(Theme.Font.body)
        Text("__HStack__(alignment: .center) { Text(\"Hello, World!\") }")
            .font(Theme.Font.code)
        Text(AttributedString("""
            - One
            - Two 
            - Three
            """))
            .font(Theme.Font.body)
    }
    .padding()
    .background(Theme.Color.backgroundPrimary)
}