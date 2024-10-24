//
//  TreeView.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 08.10.2024.
//

import SwiftUI

struct ParrentPositionsKey: PreferenceKey {
    static var defaultValue: Anchor<CGPoint>? = nil

    static func reduce(value: inout Anchor<CGPoint>?, nextValue: () -> Anchor<CGPoint>?) {
        value = value ?? nextValue()
    }
}

struct ChildPosition: Equatable, Identifiable {
    let position: Anchor<CGPoint>
    let relation: Relation

    var id: String {
        relation.id
    }
}

struct ChildPositionsKey: PreferenceKey {
    static var defaultValue: [ChildPosition] = []

    static func reduce(value: inout [ChildPosition], nextValue: () -> [ChildPosition]) {
        value = nextValue() + value
    }
}

struct RelationLine: Shape {
    let parentPoint: CGPoint
    let childPoint: CGPoint

    let middleLinePadding: CGFloat

    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: parentPoint)
            path.addLine(to: CGPoint(x: parentPoint.x, y: parentPoint.y + middleLinePadding))
            path.addLine(to: CGPoint(x: childPoint.x, y: parentPoint.y + middleLinePadding))
            path.addLine(to: childPoint)
        }
    }
}

struct TreeView: View {
    let tree: Tree

    @State
    var parrentPosition: Anchor<CGPoint>?

    @State
    var childPositions: [ChildPosition] = []

    @Environment(\.space)
    var space: Space

    var body: some View {
        VStack(alignment: .center, spacing: space.innerValue()) {
            VStack(spacing: 0) {
                Text(tree.title)
                    .style(.body.color(tree.color ?? Theme.Color.contentPrimary))
                    .background(tree.highlight ?? Color.clear)
                if let caption = tree.caption {
                    Text(caption)
                        .style(.caption.color(Theme.Color.contentSecondary))
                }
            }
            .padding(.vertical, space.innerValue(2))
            .anchorPreference(key: ParrentPositionsKey.self, value: .bottom, transform: { $0 })

            HStack(alignment: .top, spacing: space.innerValue()) {
                ForEach(tree.children) { children in
                    TreeView(tree: children)
                        .anchorPreference(key: ChildPositionsKey.self, value: .top) {
                            [ChildPosition(position: $0, relation: children.relation)]
                        }
                }
            }
        }
        .overlay {
            GeometryReader { proxy in
                ForEach(childPositions) { childPosition in
                    RelationLine(
                        parentPoint: parrentPosition.map { proxy[$0] } ?? .zero,
                        childPoint: proxy[childPosition.position],
                        middleLinePadding: 0.5 * space.innerValue(2)
                    )
                    .stroke(
                        childPosition.relation.color,
                        style: StrokeStyle(
                            lineWidth: childPosition.relation.lineWidth,
                            dash: childPosition.relation.dashed ? [5, 5] : []
                        )
                    )
                    .transition(.opacity)
                }
            }
        }
        .onPreferenceChange(ParrentPositionsKey.self) { parrentPosition = $0 }
        .onPreferenceChange(ChildPositionsKey.self) { childPositions = $0 }
        .id(tree.id)
    }
}

#Preview {
    TreeView(
        tree: Tree("Background") {
            Tree("Color")
            Tree("HStack") {
                Tree("Icon")
                Tree("VStack") {
                    Tree("Text", id: "title-text")
                    Tree("Font") {
                        Tree("Text", id: "subtitle-text")
                    }
                }
            }
        }
    )
    .framed()
    .space(.s2)
}
