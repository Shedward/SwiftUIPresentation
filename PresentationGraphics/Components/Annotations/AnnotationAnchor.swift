//
//  AnnotationAnchor.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 02.11.2024.
//

import SwiftUI

typealias AnnotationId = String

struct AnnotationAnchor {
    let id: AnnotationId
    let bounds: Anchor<CGRect>
}

struct AnnotationAnchorsKey: PreferenceKey {
    static var defaultValue: [AnnotationAnchor] = []

    static func reduce(value: inout [AnnotationAnchor], nextValue: () -> [AnnotationAnchor]) {
        value = nextValue() + value
    }
}

extension View {
    @ViewBuilder
    func annotatable(_ id: AnnotationId?) -> some View {
        if let id {
            anchorPreference(key: AnnotationAnchorsKey.self, value: .bounds) { bounds in
                [AnnotationAnchor(id: id, bounds: bounds)]
            }
        } else {
            self
        }
    }
}
