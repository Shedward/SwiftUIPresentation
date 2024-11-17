//
//  FrameIllustration.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 16.11.2024.
//

import SwiftUI
import CoreGraphics

struct GeometryIllustration: View {
    var size = CGSize(width: 500, height: 500)
    var illustrations: [any AnyIllustration]

    init(
        size: CGSize = .init(width: 400, height: 400),
        @ArrayBuilder<AnyIllustration> illustrations: () -> [any AnyIllustration]
    ) {
        self.size = size
        self.illustrations = illustrations()
    }

    var body: some View {
        Color.clear
            .frame(width: size.width, height: size.height)
            .overlay {
                ForEach(illustrations, id: \.id) { illustration in
                    illustration.anyBody()
                        .position(illustration.position)
                }
            }
    }
}

#Preview {
    GeometryIllustration {
        FrameIllustration(frame: CGRect(origin: .zero, size: CGSize(width: 300, height: 300)))
        FrameIllustration(frame: CGRect(origin: CGPoint(x: 50, y: 80), size: CGSize(width: 200, height: 200)))
    }
}
