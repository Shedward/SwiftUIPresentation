//
//  DefaultRelation.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 31.10.2024.
//

import SwiftUI

enum RelationEnvironmentKey: EnvironmentKey {
    static let defaultValue: Relation = .init()
}

extension EnvironmentValues {
    var relation: Relation {
        get { self[RelationEnvironmentKey.self] }
        set { self[RelationEnvironmentKey.self] = newValue }
    }
}

extension View {
    func relation(_ relation: Relation) -> some View {
        environment(\.relation, relation)
    }
}
