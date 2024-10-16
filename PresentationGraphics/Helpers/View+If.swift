//
//  View+If.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 16.10.2024.
//

import SwiftUI

extension View {

    @ViewBuilder
    public func `if`<ThenView: View>(_ condition: Bool, @ViewBuilder content: (Self) -> ThenView) -> some View {
        if condition {
            content(self)
        } else {
            self
        }
    }

    @ViewBuilder
    public func `if`<ThenView: View, ElseView: View>(
        _ condition: Bool,
        @ViewBuilder content: (Self) -> ThenView,
        @ViewBuilder elseContent: (Self) -> ElseView
    ) -> some View {
        if condition {
            content(self)
        } else {
            elseContent(self)
        }
    }
}
