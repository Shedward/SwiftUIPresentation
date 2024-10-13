//
//  RenderTreeNode.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 08.10.2024.
//

import Foundation
import SwiftUI

struct Tree: Identifiable {
    let id: String
    let title: String
    let relation: Relation

    let children: [Tree]

    init(
        _ id: String = UUID().uuidString,
        title: String? = nil,
        relation: Relation = Relation(),
        @ArrayBuilder<Tree> buildChildrens: () -> [Tree] = { [] }
    ) {
        self.id = id
        self.title = title ?? id
        self.relation = relation
        self.children = buildChildrens()
    }
}

struct  Relation: Equatable {
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
