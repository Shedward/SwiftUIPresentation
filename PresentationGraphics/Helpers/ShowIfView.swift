//
//  ShowIfView.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 14.11.2024.
//

import SwiftUI

struct ShowIf<Content: View>: View {

    @Environment(\.episode)
    var episode: Episode

    let show: (Episode) -> Bool
    let content: Content

    init(_ show: Bool, @ViewBuilder content: () -> Content) {
        self.show = { _ in show }
        self.content = content()
    }

    init(at episode: Episode, @ViewBuilder content: () -> Content) {
        self.show = { $0 == episode }
        self.content = content()
    }

    init(at episodes: Episode..., @ViewBuilder content: () -> Content) {
        self.show = { episodes.contains($0) }
        self.content = content()
    }

    init(after episode: Episode, @ViewBuilder content: () -> Content) {
        self.show = { $0 >= episode }
        self.content = content()
    }

    init(in episodes: ClosedRange<Episode>, @ViewBuilder content: () -> Content) {
        self.show = { episodes.contains($0) }
        self.content = content()
    }

    var body: some View {
        if show(episode) {
            content
        }
    }
}
