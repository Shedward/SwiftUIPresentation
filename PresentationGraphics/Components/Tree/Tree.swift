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
    var caption: String?
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

    func caption(_ caption: String?) -> Self {
        with { $0.caption = caption }
    }
}

struct Relation: Equatable, Withable {
    let id: String
    let title: String?
    let color: Color
    let lineWidth: CGFloat
    let dashed: Bool

    init(_ id: String = UUID().uuidString, title: String? = nil, color: Color = .blue, lineWidth: CGFloat = 1, dashed: Bool = false) {
        self.id = id
        self.title = title ?? id
        self.color = color
        self.lineWidth = lineWidth
        self.dashed = dashed
    }

    static let none = Relation(lineWidth: 0)
    static let normal = Relation()
    static let bold = Relation(lineWidth: 2)
}
