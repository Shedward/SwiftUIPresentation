//
//  View+Space.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//

import SwiftUI

struct SpaceEnvironmentKey: EnvironmentKey {
    static let defaultValue: Space = .s0
}

extension EnvironmentValues {
    var space: Space {
        get { self[SpaceEnvironmentKey.self] }
        set { self[SpaceEnvironmentKey.self] = newValue }
    }
}

struct ReduceSpacingModifier: ViewModifier {
    @Environment(\.space)
    var space: Space

    let step: Int

    func body(content: Content) -> some View {
        content.environment(\.space, space.down(step))
    }
}

struct SpacePaddingModifier: ViewModifier {
    @Environment(\.space)
    var space: Space

    var edges: Edge.Set = .all

    func body(content: Content) -> some View {
        content.padding(edges, space.value)
    }
}

struct MinMaxSpaceModifier: ViewModifier {
    @Environment(\.space)
    var space: Space

    let minSpace: Space?
    let maxSpace: Space?

    func body(content: Content) -> some View {
        content.environment(\.space, min(maxSpace ?? space, max(minSpace ?? space, space)))
    }
}

extension View {
    func space(_ space: Space) -> some View {
        environment(\.space, space)
    }

    func reduceSpacing(by step: Int = 1) -> some View {
        modifier(ReduceSpacingModifier(step: step))
    }

    func spacePadding(edges: Edge.Set) -> some View {
        modifier(SpacePaddingModifier(edges: edges))
    }

    func spaced(step: Int = 1, edges: Edge.Set = .all) -> some View {
        spacePadding(edges: edges)
            .reduceSpacing(by: step)
    }

    func space(minSpace: Space? , maxSpace: Space?) -> some View {
        modifier(MinMaxSpaceModifier(minSpace: minSpace, maxSpace: maxSpace))
    }
}

#Preview {
    Rectangle()
        .background(.red)
        .spaced()
        .background(.blue)
        .spaced()
        .background(.red)
        .spaced()
        .background(.blue)
        .spaced()
        .background(.red)
        .spaced()
        .background(.blue)
        .spaced()
        .background(.red)
        .spaced()
}
