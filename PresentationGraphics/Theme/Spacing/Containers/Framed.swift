//
//  Framed.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//

import SwiftUI

struct FramedViewModifier: ViewModifier {
    @Environment(\.space)
    var space: Space

    let step: Int
    let fill: Color?
    let stroke: Color?
    let strokeWidth: CGFloat

    func body(content: Content) -> some View {
        content
            .spaced(step: step)
            .containerShape(RoundedRectangle(cornerRadius: space.innerValue()))
            .background {
                RoundedRectangle(cornerRadius: space.innerValue())
                    .fill(fill ?? Color.clear)
                    .strokeBorder(stroke ?? Color.clear, lineWidth: strokeWidth)
            }
    }
}


extension View {
    public func framed(step: Int = 1, fill: Color? = nil, stroke: Color = .clear, strokeWidth: CGFloat = 1) -> some View {
        modifier(FramedViewModifier(step: step, fill: fill, stroke: stroke, strokeWidth: strokeWidth))
    }
}

#Preview {
    Rectangle()
        .framed(fill: .blue)
        .framed(stroke: .white)
        .framed(fill: .red)
        .framed(fill: .orange, stroke: .green, strokeWidth: 5)
}
