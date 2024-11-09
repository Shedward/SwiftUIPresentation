//
//  AnnotationShapes.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 03.11.2024.
//

import SwiftUI

extension AnnotationShape {
    static let binding = AnnotationShape { fromRect, toRect in
        Path { path in
            let fromPoint = fromRect.midLeft
            let toPoint = toRect.midLeft
            let perp = fromPoint.perpendicular(to: toPoint, length: 0.25 * fromPoint.distance(to: toPoint))
            let controlPoint = fromPoint.midPoint(to: toPoint).adding(perp)

            path.move(to: fromPoint)
            path.addQuadCurve(to: toPoint, control: controlPoint)
        }
        .strokedPath(.init(lineWidth: 3))
    }

    static let animation = AnnotationShape { fromRect, toRect in
        Path { path in
            let fromPoint = fromRect.midBottom
            let toPoint = toRect.midBottom
            let perp = fromPoint.perpendicular(to: toPoint, length: 0.25 * fromPoint.distance(to: toPoint))
            let controlPoint = fromPoint.midPoint(to: toPoint).adding(perp.negated())

            path.move(to: fromPoint)
            path.addQuadCurve(to: toPoint, control: controlPoint)
        }
        .strokedPath(.init(lineWidth: 3))
    }
}
