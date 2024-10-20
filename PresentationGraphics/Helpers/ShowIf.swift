//
//  ShowIf.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 17.10.2024.
//

import SwiftUI

protocol ShowIfable {
    func showIf(_ episode: String, after: String) -> Self?
    func hideIf(_ episode: String, after: String) -> Self?

    func showIf(_ episode: String, at: String) -> Self?
    func hideIf(_ episode: String, at: String) -> Self?

    func showIf(_ episode: String, in: ClosedRange<String>) -> Self?
    func hideIf(_ episode: String, in: ClosedRange<String>) -> Self?
}

extension ShowIfable {
    func showIf(_ episode: String, after: String) -> Self? {
        PresentationGraphics.showIf(episode, after: after) { self }
    }

    func hideIf(_ episode: String, after: String) -> Self? {
        PresentationGraphics.hideIf(episode, after: after) { self }
    }

    func showIf(_ episode: String, at: String) -> Self? {
        PresentationGraphics.showIf(episode, at: at) { self }
    }

    func hideIf(_ episode: String, at: String) -> Self? {
        PresentationGraphics.hideIf(episode, at: at) { self }
    }

    func showIf(_ episode: String, in range: ClosedRange<String>) -> Self? {
        PresentationGraphics.showIf(episode, in: range) { self }
    }

    func hideIf(_ episode: String, in range: ClosedRange<String>) -> Self? {
        PresentationGraphics.hideIf(episode, in: range) { self }
    }
}

extension String: ShowIfable { }

func showIf<T>(_ episode: String, after: String, _ block: () -> T) -> T? {
    if episode >= after {
        block()
    } else {
        nil
    }
}

func hideIf<T>(_ episode: String, after: String, _ block: () -> T) -> T? {
    if episode >= after {
        nil
    } else {
        block()
    }
}

func showIf<T>(_ episode: String, at: String, _ block: () -> T) -> T? {
    if episode == at {
        block()
    } else {
        nil
    }
}

func hideIf<T>(_ episode: String, at: String, _ block: () -> T) -> T? {
    if episode == at {
        nil
    } else {
        block()
    }
}

func showIf<T>(_ episode: String, in range: ClosedRange<String>, _ block: () -> T) -> T? {
    if range.contains(episode) {
        block()
    } else {
        nil
    }
}

func hideIf<T>(_ episode: String, in range: ClosedRange<String>, _ block: () -> T) -> T? {
    if range.contains(episode) {
        nil
    } else {
        block()
    }
}
