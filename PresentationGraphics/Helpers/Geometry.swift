//
//  Geometry.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 03.11.2024.
//

import CoreGraphics

extension CGRect: Withable {
    var topRight: CGPoint {
        CGPoint(x: maxX, y: minY)
    }

    var midRight: CGPoint {
        CGPoint(x: maxX, y: midY)
    }

    var bottomRight: CGPoint {
        CGPoint(x: maxX, y: maxY)
    }

    var topLeft: CGPoint {
        CGPoint(x: minX, y: minY)
    }

    var midLeft: CGPoint {
        CGPoint(x: minX, y: midY)
    }

    var bottomLeft: CGPoint {
        CGPoint(x: minX, y: maxY)
    }
}

extension CGPoint: Withable {
    func distance(to other: CGPoint) -> CGFloat {
        sqrt(pow(x - other.x, 2) + pow(y - other.y, 2))
    }

    func midPoint(to other: CGPoint) -> CGPoint {
        CGPoint(x: (x + other.x) / 2, y: (y + other.y) / 2)
    }

    func perpendicular(to: CGPoint, length: CGFloat) -> CGVector {
        parallel(to: to, length: length)
            .quadRotated(1)
    }

    func parallel(to: CGPoint, length: CGFloat) -> CGVector {
        let dx = to.x - x
        let dy = to.y - y

        let magnitude = sqrt(dx * dx + dy * dy)
        let unitDx = dx / magnitude
        let unitDy = dy / magnitude

        let scaledParallelDx = unitDx * length
        let scaledParallelDy = unitDy * length
        
        return CGVector(dx: scaledParallelDx, dy: scaledParallelDy)
    }

    func adding(_ vector: CGVector) -> CGPoint {
        CGPoint(x: x + vector.dx, y: y + vector.dy)
    }

    func adding(_ point: CGPoint) -> CGPoint {
        CGPoint(x: x + point.x, y: y + point.y)
    }

    func negated() -> CGPoint {
        CGPoint(x: -x, y: -y)
    }

    func adding(dx: CGFloat = 0, dy: CGFloat = 0) -> CGPoint {
        CGPoint(x: x + dx, y: y + dy)
    }
}

extension CGVector: Withable {
    func negated() -> CGVector {
        CGVector(dx: -dx, dy: -dy)
    }

    func rotated(by angle: CGFloat) -> CGVector {
        let radians = angle * .pi / 180

        let cos = cos(radians)
        let sin = sin(radians)
        
        return CGVector(dx: dx * cos - dy * sin, dy: dx * sin + dy * cos)
    }

    func quadRotated(_ quadrant: Int) -> CGVector {
        switch quadrant % 4 {
            case 0:
                return self
            case 1:
                return CGVector(dx: dy, dy: -dx)
            case 2:
                return CGVector(dx: -dx, dy: -dy)
            case 3:
                return CGVector(dx: -dy, dy: dx)
            default:
                return self
        }
    }
}
