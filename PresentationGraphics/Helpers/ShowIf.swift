//
//  ShowIf.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 17.10.2024.
//

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
        if episode >= after {
            self
        } else {
            nil
        }
    }

    func hideIf(_ episode: String, after: String) -> Self? {
        if episode >= after {
            nil
        } else {
            self
        }
    }

    func showIf(_ episode: String, at: String) -> Self? {
        if episode == at {
            self
        } else {
            nil
        }
    }

    func hideIf(_ episode: String, at: String) -> Self? {
        if episode == at {
            nil
        } else {
            self
        }
    }

    func showIf(_ episode: String, in range: ClosedRange<String>) -> Self? {
        if range.contains(episode) {
            self
        } else {
            nil
        }
    }

    func hideIf(_ episode: String, in range: ClosedRange<String>) -> Self? {
        if range.contains(episode) {
            nil
        } else {
            self
        }
    }
}
