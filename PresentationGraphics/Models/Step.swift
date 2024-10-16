//
//  Step.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 15.10.2024.
//

import SwiftUI

struct Step: ExpressibleByStringLiteral {
    let id: String
    let action: @MainActor () -> Void

    init(_ id: String, action: @escaping @MainActor () -> Void = { }) {
        self.id = id
        self.action = action
    }

    init(stringLiteral value: String) {
        self.init(value)
    }
}

struct StepKey: EnvironmentKey {
    static let defaultValue: String = ""
}

extension EnvironmentValues {
    public var step: String {
        get { self[StepKey.self] }
        set { self[StepKey.self] = newValue }
    }
}

extension View {
    public func step(_ id: String) -> some View {
        environment(\.step, id)
    }
}
