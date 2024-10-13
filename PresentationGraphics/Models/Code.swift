//
//  Code.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 09.10.2024.
//

import Observation

@Observable
final class Code: ExpressibleByStringLiteral {
    let lines: [Line]

    init(lines: [Line]) {
        self.lines = lines
    }

    init(_ text: String) {
        lines = text.split(separator: "\n").enumerated().map { index, line in
            Line(index: index + 1, text: String(line))
        }
    }

    convenience init(stringLiteral value: String) {
        self.init(value)
    }
}

extension Code {
    struct Line {
        let index: Int
        let text: String
    }
}
