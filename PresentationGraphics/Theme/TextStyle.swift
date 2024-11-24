//
//  TextStyle.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//

import SwiftUI

struct TextStyle {
    var font: Font
    var color: Color
}

extension TextStyle: Withable {
    func color(_ color: Color) -> Self {
        with { $0.color = color }
    }

    func font(_ font: Font) -> Self {
        with { $0.font = font }
    }
}

extension TextStyle {
    static let cover = TextStyle(font: Theme.Font.h0, color: Theme.Color.contentPrimary)
    static let body = TextStyle(font: Theme.Font.body, color: Theme.Color.contentPrimary)
    static let bodySmall = TextStyle(font: Theme.Font.bodySmall, color: Theme.Color.contentPrimary)
    static let code = TextStyle(font: Theme.Font.code, color: Theme.Color.contentPrimary)
    static let codeSmall = TextStyle(font: Theme.Font.codeSmall, color: Theme.Color.contentPrimary)
    static let codeExtraSmall = TextStyle(font: Theme.Font.codeExtraSmall, color: Theme.Color.contentPrimary)
    static let title = TextStyle(font: Theme.Font.h1, color: Theme.Color.contentPrimary)
    static let subtitle = TextStyle(font: Theme.Font.h2, color: Theme.Color.contentSecondary)
    static let caption = TextStyle(font: Theme.Font.caption, color: Theme.Color.contentSecondary)
    static let captionSmall = TextStyle(font: Theme.Font.captionSmall, color: Theme.Color.contentSecondary)
    static let debug = TextStyle(font: Theme.Font.code, color: Theme.Color.debug)
}

private struct TextStyleModifier: ViewModifier {
    let style: TextStyle
    
    func body(content: Content) -> some View {
        content
            .font(style.font)
            .foregroundStyle(style.color)
    }
}

extension View {
    func style(_ style: TextStyle) -> some View {
        modifier(TextStyleModifier(style: style))
    }

    func style(font: Font = Theme.Font.body, color: Color = Theme.Color.contentPrimary) -> some View {
        modifier(TextStyleModifier(style: TextStyle(font: font, color: color)))
    }
}
