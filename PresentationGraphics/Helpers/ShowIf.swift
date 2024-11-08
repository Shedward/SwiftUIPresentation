//
//  ShowIf.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 17.10.2024.
//

import SwiftUI

protocol ShowIfable {
    func showIf(_ episode: Episode, after: Episode) -> Self?
    func hideIf(_ episode: Episode, after: Episode) -> Self?

    func showIf(_ episode: Episode, at: Episode) -> Self?
    func hideIf(_ episode: Episode, at: Episode) -> Self?

    func showIf(_ episode: Episode, in: ClosedRange<Episode>) -> Self?
    func hideIf(_ episode: Episode, in: ClosedRange<Episode>) -> Self?

    func showIf(_ episode: Episode, in episodes: Episode...) -> Self?
}

extension ShowIfable {
    func showIf(_ episode: Episode, after: Episode) -> Self? {
        PresentationGraphics.showIf(episode, after: after) { self }
    }

    func hideIf(_ episode: Episode, after: Episode) -> Self? {
        PresentationGraphics.hideIf(episode, after: after) { self }
    }

    func showIf(_ episode: Episode, at: Episode) -> Self? {
        PresentationGraphics.showIf(episode, at: at) { self }
    }

    func hideIf(_ episode: Episode, at: Episode) -> Self? {
        PresentationGraphics.hideIf(episode, at: at) { self }
    }

    func showIf(_ episode: Episode, in range: ClosedRange<Episode>) -> Self? {
        PresentationGraphics.showIf(episode, in: range) { self }
    }

    func hideIf(_ episode: Episode, in range: ClosedRange<Episode>) -> Self? {
        PresentationGraphics.hideIf(episode, in: range) { self }
    }

    func showIf(_ episode: Episode, in episodes: Episode...) -> Self? {
        if episodes.contains(episode) {
            self
        } else {
            nil
        }
    }
}

extension String: ShowIfable { }

func showIf<T>(_ episode: Episode, after: Episode, _ block: () -> T) -> T? {
    if episode >= after {
        block()
    } else {
        nil
    }
}

@ViewBuilder
func showIf<T: View>(_ episode: Episode, after: Episode, @ViewBuilder _ block: () -> T) -> some View {
    if episode >= after {
        block()
    } else {
        EmptyView()
    }
}

func hideIf<T>(_ episode: Episode, after: Episode, _ block: () -> T) -> T? {
    if episode >= after {
        nil
    } else {
        block()
    }
}

func showIf<T>(_ episode: Episode, after: Episode, @ArrayBuilder<T> _ block: () -> [T]) -> [T] {
    if episode >= after {
        block()
    } else {
        []
    }
}

func showIf<T>(_ episode: Episode, at: Episode, _ block: () -> T) -> T? {
    if episode == at {
        block()
    } else {
        nil
    }
}

func showIf<T>(_ episode: Episode, at: Episode, @ArrayBuilder<T> _ block: () -> [T]) -> [T] {
    if episode == at {
        block()
    } else {
        []
    }
}

func hideIf<T>(_ episode: Episode, at: Episode, _ block: () -> T) -> T? {
    if episode == at {
        nil
    } else {
        block()
    }
}

func showIf<T>(_ episode: Episode, in range: ClosedRange<Episode>, _ block: () -> T) -> T? {
    if range.contains(episode) {
        block()
    } else {
        nil
    }
}

func showIf<T>(_ episode: Episode, in range: ClosedRange<Episode>, @ArrayBuilder<T> _ block: () -> [T]) -> [T] {
    if range.contains(episode) {
        block()
    } else {
        []
    }
}

func showIf<T>(_ episode: Episode, in episodes: Episode..., @ArrayBuilder<T> block: () -> [T]) -> [T] {
    if episodes.contains(episode) {
        block()
    } else {
        []
    }
}

func hideIf<T>(_ episode: Episode, in range: ClosedRange<Episode>, _ block: () -> T) -> T? {
    if range.contains(episode) {
        nil
    } else {
        block()
    }
}
