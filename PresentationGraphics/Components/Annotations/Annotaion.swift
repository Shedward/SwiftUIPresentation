//
//  Annotaion.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 13.11.2024.
//

import SwiftUI

protocol AnyAnnotation {
    var id: String { get }

    func body(proxy: GeometryProxy, anchors: [AnnotationAnchor]) -> AnyView
}

protocol Annotation: Identifiable, AnyAnnotation {
    associatedtype Content: View

    var id: String { get }

    @ViewBuilder
    func body(anchor: (AnnotationId) -> CGRect?) -> Content
}

extension Annotation {

    func body(proxy: GeometryProxy, anchors: [AnnotationAnchor]) -> AnyView {
        AnyView(
            body(
                anchor: { id in
                    guard let anchor = anchors.first(where: { $0.id == id }) else {
                        return nil
                    }

                    let insets = 0.5 * Space.min.value
                    let bounds = proxy[anchor.bounds].insetBy(dx: -insets, dy: -insets)

                    return bounds
                }
            )
        )
    }
}
