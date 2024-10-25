//
//  Paddings.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//

import SwiftUI

struct Space: Comparable, Equatable {

    static func < (lhs: Space, rhs: Space) -> Bool {
        lhs.value < rhs.value
    }

    static func == (lhs: Space, rhs: Space) -> Bool {
        lhs.value == rhs.value
    }

    static let step = CGFloat(16)

    let value: CGFloat

    func down(_ mult: Int = 1) -> Self {
        addStep(-mult)
    }

    func up(_ mult: Int = 1) -> Self {
        addStep(mult)
    }

    func innerValue(_ step: Int = 1) -> CGFloat {
        down(step).value
    }

    static let max: Space = .init(value: 80)
    static let min: Space = .init(value: 8)

    static let s0: Space = max
    static let s1: Space = s0.down()
    static let s2: Space = s1.down()
    static let s3: Space = s2.down()
    static let s4: Space = s3.down()
    static let s5: Space = s4.down()

    private func addStep(_ mult: Int) -> Space {
        var newValue = value + CGFloat(mult) * Space.step
        if newValue > Space.max.value {
            newValue = Space.max.value
        }
        if newValue < Space.min.value {
            newValue = Space.min.value
        }
        return Space(value: newValue)
    }
}
