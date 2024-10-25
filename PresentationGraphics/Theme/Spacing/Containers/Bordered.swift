//
//  Bordered.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 16.10.2024.
//

import SwiftUI

struct BorderedViewModifier: ViewModifier {
    let strokeWidth: CGFloat

    func body(content: Content) -> some View {
        content
            .overlay {
                Rectangle()
                    .fill(Color.clear)
                    .strokeBorder(style: .init(lineWidth: strokeWidth, dash: [10, 5]))
            }
    }
}

extension View {
    public func bordered(strokeWidth: CGFloat = 1) -> some View {
        modifier(BorderedViewModifier(strokeWidth: strokeWidth))
    }
}
