//
//  LayoutFrame.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 13.11.2024.
//

import SwiftUI

struct LayoutFrame: View {

    let size: CGSize?
    let position: CGPoint?

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: "squareshape.dotted.squareshape")
            VStack(alignment: .leading) {
                Text("origin:")
                Text("size:")
            }
            VStack(alignment: .leading) {
                Text(positionDescription)
                Text(sizeDescription)
            }

        }
        .style(.codeSmall.color(Theme.Color.contentSecondary))
    }

    private var sizeDescription: String {
        if let size {
            return "\(size.width) x \(size.height)"
        } else {
            return "–"
        }
    }

    private var positionDescription: String {
        if let position {
            return "\(position.x), \(position.y)"
        } else {
            return "–"
        }
    }
}

#Preview {
    LayoutFrame(size: nil, position: CGPoint(x: 50, y: 50))
}
