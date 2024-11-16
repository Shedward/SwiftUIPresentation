//
//  LineAnnotation.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 13.11.2024.
//

import SwiftUI

struct LineAnnotation: Annotation, Withable {
    let id: String
    let from: AnnotationId
    let to: AnnotationId
    var path: LinePath
    var stroke: Color = .clear
    var fill: Color = .clear

    init(id: String, from: AnnotationId, to: AnnotationId, path: @escaping LinePath = Self.midLine) {
        self.id = id
        self.from = from
        self.to = to
        self.path = path
    }

    init(from: AnnotationId, to: AnnotationId, path: @escaping LinePath = Self.midLine, file: StaticString = #fileID, line: UInt = #line) {
        self.id = LineId(file: file, line: line).id
        self.from = from
        self.to = to
        self.path = path
    }

    func body(anchor: (AnnotationId) -> CGRect?) -> some View {
        if let fromAnchor = anchor(from), let toAnchor = anchor(to) {
            path(fromAnchor, toAnchor)
                .stroke(stroke, lineWidth: 3)
                .fill(fill)
        }
    }

    func path(_ path: @escaping LinePath) -> Self {
        with { $0.path = path }
    }

    func fill(_ fill: Color) -> Self {
        with { $0.fill = fill }
    }

    func stroke(_ stroke: Color) -> Self {
        with { $0.stroke = stroke }
    }
}

extension LineAnnotation {
    typealias LinePath = (_ from: CGRect, _ to: CGRect) -> Path


    static func midLine(_ from: CGRect, _ to: CGRect) -> Path {
        Path { path in
            path.move(to: from.midRight)
            path.addLine(to: to.midRight)
        }
    }

    static func leftArc(_ from: CGRect, to: CGRect) -> Path {
        Path { path in
            let fromPoint = from.midLeft
            let toPoint = to.midLeft
            let perp = fromPoint.perpendicular(to: toPoint, length: 0.25 * fromPoint.distance(to: toPoint))
            let controlPoint = fromPoint.midPoint(to: toPoint).adding(perp)

            path.move(to: fromPoint)
            path.addQuadCurve(to: toPoint, control: controlPoint)
        }
    }

    static func bottomArc(_ from: CGRect, to: CGRect) -> Path {
        Path { path in
            let fromPoint = from.midBottom
            let toPoint = to.midBottom
            let perp = fromPoint.perpendicular(to: toPoint, length: 0.25 * fromPoint.distance(to: toPoint))
            let controlPoint = fromPoint.midPoint(to: toPoint).adding(perp.negated())

            path.move(to: fromPoint)
            path.addQuadCurve(to: toPoint, control: controlPoint)
        }
    }
}

extension LineAnnotation {
    func bindingKind() -> LineAnnotation {
        path(LineAnnotation.leftArc)
            .stroke(Theme.Color.binding)
    }

    func animationKind() -> LineAnnotation {
        path(LineAnnotation.bottomArc)
            .stroke(Theme.Color.animation)
    }
}
