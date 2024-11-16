//
//  EdgeCalloutLayout.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 13.11.2024.
//

import SwiftUI

struct EdgeCalloutLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        subviews.forEach { subview in
            let edge = subview[EdgeCalloutPositionLayoutKey.self]
            subview.place(
                at: bounds.unitPoint(edge),
                anchor: edge.inverted(),
                proposal: ProposedViewSize(width: nil, height: nil))
        }
    }
}
