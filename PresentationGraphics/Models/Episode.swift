//
//  Episode.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 15.10.2024.
//

import SwiftUI

struct Episode: Comparable, Equatable {
    let id: String
    let notes: String?

    init(_ id: String, notes: String? = nil) {
        self.id = id
        self.notes = notes
    }

    static func < (lhs: Episode, rhs: Episode) -> Bool {
        lhs.id < rhs.id
    }

    static func == (lhs: Episode, rhs: Episode) -> Bool {
        lhs.id == rhs.id
    }
}

struct EpisodeKey: EnvironmentKey {
    static let defaultValue: Episode = e00
}

extension EnvironmentValues {
    var episode: Episode {
        get { self[EpisodeKey.self] }
        set { self[EpisodeKey.self] = newValue }
    }
}

extension View {
    func episode(_ episode: Episode) -> some View {
        environment(\.episode, episode)
    }
}
