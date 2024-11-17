//
//  GeometryReaderExample.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 17.11.2024.
//

import SwiftUI

public struct TwoColumn<Content: View>: View {

    let spacing: CGFloat = 16
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .topLeading) {
                content()
                    .frame(width: 0.5 * (proxy.size.width - spacing))

                content()
                    .frame(width: 0.5 * (proxy.size.width - spacing))
                    .offset(x: 0.5 * proxy.size.width + spacing)
            }
        }
    }
}

#Preview {
    TwoColumn{
        Rectangle()
    }
    .frame(width: 300, height: 300)
}
