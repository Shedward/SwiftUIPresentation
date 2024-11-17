//
//  CustomLayout.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 16.11.2024.
//

import SwiftUI

public struct CustomVerticalLayout: Layout {
    public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let sizes = subviews.map { subview in
            subview.sizeThatFits(
                ProposedViewSize(width: proposal.width, height: nil)
            )
        }

        return CGSize(
            width: sizes.map(\.width).max() ?? 0,
            height: sizes.map(\.height).reduce(0, +)
        )
    }
    
    public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var position = bounds.unitPoint(.top)
        let proposal = ProposedViewSize(width: proposal.width, height: nil)

        subviews.forEach { subview in
            let subviewSize = subview.sizeThatFits(proposal)
            subview.place(
                at: position,
                anchor: UnitPoint(x: 0.5, y: 0),
                proposal: proposal
            )
            position.y += subviewSize.height
        }
    }
}


#Preview {
    CustomVerticalLayout {
        Text("One")
        Text("Multiline many words string to test the layout")
        Text("Two")
        Image(systemName: "arrow.2.circlepath.circle")
    }
}
