//
//  Slide.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//

import SwiftUI

protocol Slide {
    var id: String { get }
    var content: AnyView { get }

    @ArrayBuilder<Step> var steps: [Step] { get }
}

extension Slide where Self: View {
    var id: String {
        "\(type(of: self))"
    }

    var content: AnyView {
        AnyView(self)
    }

    var steps: [Step] {
        []
    }
}
