//
//  View+onKeysPress.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//

import SwiftUI

extension View {
    public func onKeysPress(_ keys: KeyEquivalent..., perform action: @escaping () -> Void) -> some View {
        onKeyPress(keys: Set(keys)) { press in
            action()
            return .handled
        }
    }
}
