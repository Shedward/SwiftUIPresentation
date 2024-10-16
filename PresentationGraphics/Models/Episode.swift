//
//  Episode.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 15.10.2024.
//

import SwiftUI

struct Episode: ExpressibleByStringLiteral {
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

struct EpisodeKey: EnvironmentKey {
    static let defaultValue: String = ""
}

extension EnvironmentValues {
    public var episode: String {
        get { self[EpisodeKey.self] }
        set { self[EpisodeKey.self] = newValue }
    }
}

extension View {
    public func episode(_ id: String) -> some View {
        environment(\.episode, id)
    }
}
