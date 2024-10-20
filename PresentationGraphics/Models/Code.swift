//
//  Code.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 09.10.2024.
//

import Observation

final class Code {
    var lines: [Line]

    init(lines: [Line]) {
        self.lines = lines
    }

    init(@LinesBuilder lines: () -> [Line]) {
        self.lines = lines()
    }

    init(_ text: String, file: StaticString = #fileID, line: UInt = #line) {
        lines = LinesBuilder.buildFinalResult(CodePart.split(text, lineId: .init(file: file, line: line)))
    }
}

extension Code {
    struct Line {
        let index: Int
        let part: CodePart

        init(index: Int, part: CodePart) {
            self.index = index
            self.part = part
        }
    }
}
