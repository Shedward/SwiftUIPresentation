//
//  RenderTreeNode.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 08.10.2024.
//

import Foundation
import SwiftUI

struct Tree: Identifiable, Withable {
    var id: String
    var title: String
    var relation: Relation
    var highlight: Color?
    var color: Color?

    var children: [Tree]

    init(
        _ title: String,
        id: String? = nil,
        relation: Relation = Relation(),
        highlight: Color? = nil,
        color: Color? = nil,
        @ArrayBuilder<Tree> buildChildrens: () -> [Tree] = { [] }
    ) {
        self.id = id ?? title
        self.title = title
        self.relation = relation
        self.children = buildChildrens()
        self.highlight = highlight
        self.color = color
    }

    func highlight(_ highlight: Color? = Theme.Color.highlight) -> Self {
        with { $0.highlight = highlight }
    }

    func highlight(_ isHightlighted: Bool) -> Self {
        highlight(isHightlighted ? Theme.Color.highlight : nil)
    }

    func color(_ color: Color = Theme.Color.darkHighlight) -> Self {
        with { $0.color = color }
    }

    func relation(_ relation: Relation) -> Self {
        with { $0.relation = relation }
    }
}

struct  Relation: Equatable, Withable {
    let id: String
    let title: String?
    let color: Color
    let lineWidth: CGFloat

    init(_ id: String = UUID().uuidString, title: String? = nil, color: Color = .blue, lineWidth: CGFloat = 1) {
        self.id = id
        self.title = title ?? id
        self.color = color
        self.lineWidth = lineWidth
    }

    static let normal = Relation()
    static let bold = Relation(lineWidth: 2)
}
