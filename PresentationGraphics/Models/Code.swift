//
//  Code.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 09.10.2024.
//

import Observation

final class Code: ExpressibleByStringLiteral {
    var lines: [Line]

    init(lines: [Line]) {
        self.lines = lines
    }

    init(@LinesBuilder lines: () -> [Line]) {
        self.lines = lines()
    }

    init(_ text: String) {
        let initialLines = text.split(separator: "\n").enumerated().map { index, line in
            Line(index: index + 1, part: CodePart(String(line)))
        }
        lines = initialLines
    }

    convenience init(stringLiteral value: String) {
        self.init(value)
    }
}

extension Code {
    struct Line {
        let id: String
        let index: Int
        let part: CodePart

        init(index: Int, part: CodePart) {
            self.id = part.id ?? "\(index)"
            self.index = index
            self.part = part
        }
    }
}
