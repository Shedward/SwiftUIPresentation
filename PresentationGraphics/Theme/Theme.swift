//
//  Theme.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 09.10.2024.
//

import SwiftUI

enum Theme {
    enum Font {
        static let h0 = SwiftUI.Font.custom("Helvetica Neue Bold", size: 100)
        static let h1 = SwiftUI.Font.custom("Helvetica Neue Bold", size: 60)
        static let h2 = SwiftUI.Font.custom("Helvetica Neue Bold", size: 30)
        static let h3 = SwiftUI.Font.custom("Helvetica Neue Bold", size: 24)

        static let hSmall = SwiftUI.Font.custom("Helvetica Neue Bold", size: 18)
        static let body = SwiftUI.Font.custom("Helvetica Neue", size: 20)
        static let bodySmall = SwiftUI.Font.custom("Helvetica Neue", size: 16)
        static let code = SwiftUI.Font.custom("JetBrains Mono", size: 18)
        static let codeSmall = SwiftUI.Font.custom("JetBrains Mono", size: 16)
        static let codeExtraSmall = SwiftUI.Font.custom("JetBrains Mono", size: 14)
        static let caption = SwiftUI.Font.custom("Helvetica Nueue", size: 16)
        static let captionSmall = SwiftUI.Font.custom("Helvetica Nueue", size: 14)
        static let captionExtraSmall = SwiftUI.Font.custom("Helvetica Nueue", size: 12)
    }

    enum Color {
        static let backgroundPrimary = SwiftUI.Color(hex: 0xffffff)
        static let backgroundSecondary = SwiftUI.Color(hex: 0xfafafc)
        static let contentPrimary = SwiftUI.Color(hex: 0x000000)
        static let contentSecondary = SwiftUI.Color(hex: 0x808080)
        static let contentTertiary = SwiftUI.Color(hex: 0xd2d2d7)
        static let tintPrimary = SwiftUI.Color(hex: 0x0066cc)
        static let tintSecondary = SwiftUI.Color(hex: 0xff610d)
        static let highlight = SwiftUI.Color.yellow
        static let darkHighlight = SwiftUI.Color(hex: 0xc59f19)
        static let debug = SwiftUI.Color.purple
        static let important = SwiftUI.Color.orange

        static let lifecycleAppear = SwiftUI.Color.green
        static let lifecycleChange = SwiftUI.Color.yellow
        static let lifecycleDisappear = SwiftUI.Color.red

        static let binding = SwiftUI.Color.purple
        static let animation = tintSecondary
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
