//
//  AnnotationShapes.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 03.11.2024.
//

import SwiftUI

extension AnnotationShape {
    static let binding = AnnotationShape { from, to in
        Path { path in
            let iconOffset: CGFloat = 16
            let fromWidth: CGFloat = 4
            let toWidth: CGFloat = 16

            let fromPoint = from.topLeft.adding(dx: iconOffset)
            let toPoint = to.bottomLeft.adding(dx: iconOffset)


            path.move(to: fromPoint.adding(dx: -0.5 * fromWidth))
            path.addLine(to: fromPoint.adding(dx: 0.5 * fromWidth))

            path.addLine(to: toPoint.adding(dx: 0.5 * toWidth))
            path.addLine(to: toPoint.adding(dx: -0.5 * toWidth))
            path.closeSubpath()
        }
    }
}
