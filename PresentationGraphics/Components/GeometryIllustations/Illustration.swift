
//
//  Illustration.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 16.11.2024.
//

import SwiftUI

protocol AnyIllustration {
    var id: String { get }
    var position: CGPoint { get }
    var anchor: UnitPoint { get }

    func anyBody() -> AnyView
}

protocol Illustration: AnyIllustration {
    associatedtype Content: View

    func body() -> Content
}

extension Illustration {
    var position: CGPoint { .zero }
    var anchor: UnitPoint { .topLeading }

    func anyBody() -> AnyView {
        AnyView(body())
    }
}
