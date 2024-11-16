//
//  TextAnnotation.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 13.11.2024.
//

import SwiftUI

struct TextAnnotation: Annotation, Withable {
    let id: String
    let to: AnnotationId
    let message: String

    var style: TextStyle = .body
    var position: UnitPoint = .bottom

    init(to: AnnotationId, message: String, file: StaticString = #fileID, line: UInt = #line) {
        self.id = LineId(file: file, line: line).id
        self.message = message
        self.to = to
    }

    func body(anchor: (AnnotationId) -> CGRect?) -> some View {
        if let frame = anchor(to) {
            Box(size: frame.size)
                .edgeCallout {
                    Text(message)
                        .style(style)
                        .edgeCalloutPosition(position)
                }
                .transition(TextAnnotationTransition(direction: position))
                .position(frame.center)
        }
    }

    func style(_ style: TextStyle) -> Self {
        with { $0.style = style }
    }

    func position(_ position: UnitPoint) -> Self {
        with { $0.position = position }
    }
}

struct TextAnnotationTransition: Transition {
    let distance = Space.min.up().value
    let direction: UnitPoint

    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .offset(offset(for: phase).size())
            .opacity(phase.isIdentity ? 1.0 : 0.0)
    }

    private func offset(for phase: TransitionPhase) -> CGVector {
        switch phase {
        case .willAppear:
            direction.vector(magnitude: distance).negated()
        case .identity:
            .zero
        case .didDisappear:
            direction.vector(magnitude: distance)
        }
    }
}

extension TextAnnotation {
    func parentProposeKind() -> TextAnnotation {
        style(.codeSmall.color(Theme.Color.tintPrimary))
            .position(.halfBottomTrailing)
    }

    func childResponseKind() -> TextAnnotation {
        style(.codeSmall.color(Theme.Color.tintSecondary))
            .position(.halfTopLeading)
    }
}
