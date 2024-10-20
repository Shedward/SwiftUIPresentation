//
//  LinesBuilder.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 16.10.2024.
//

import SwiftUI

@resultBuilder
enum LinesBuilder {

    static func buildExpression(_ expression: [CodePart]) -> [CodePart] {
        expression
    }

    static func buildExpression(_ expression: [CodePart]?) -> [CodePart] {
        expression ?? []
    }

    static func buildExpression(_ expression: String, file: StaticString = #fileID, line: UInt = #line) -> [CodePart] {
        CodePart.split(expression, lineId: .init(file: file, line: line))
    }

    static func buildExpression(_ expression: String?, file: StaticString = #fileID, line: UInt = #line) -> [CodePart] {
        expression.map { LinesBuilder.buildExpression($0, file: file, line: line) } ?? []
    }

    static func buildExpression(_ expression: CodePart) -> [CodePart] {
        [expression]
    }

    static func buildOptional(_ expression: [CodePart]?) -> [CodePart] {
        expression ?? []
    }

    public static func buildEither(first expression: [CodePart]) -> [CodePart] {
        expression
    }

    public static func buildEither(second expression: [CodePart]) -> [CodePart] {
        expression
    }

    static func buildBlock(_ components: [CodePart]...) -> [CodePart] {
        components.flatMap(\.self)
    }

    static func buildFinalResult(_ component: [CodePart]) -> [Code.Line] {
        component.enumerated().map { index, part in
            Code.Line(index: index + 1, part: part)
        }
    }
}

struct CodePart: Withable {
    var lineId: LineId
    var text: String
    var highlight: Color?
    var color: Color?

    private init(_ text: String, lineId: LineId) {
        self.text = text
        self.lineId = lineId
    }

    func highlight(_ highlight: Color?) -> Self {
        with { $0.highlight = highlight }
    }

    func color(_ color: Color?) -> Self {
        with { $0.color = color }
    }

    static func split(_ text: String, lineId: LineId) -> [Self] {
        text.split(separator: "\n").enumerated().map { index, text in
            CodePart(String(text), lineId: lineId.innerLineIndex(index))
        }
    }
}

func color(_ color: Color? = Theme.Color.darkHighlight, @LinesBuilder _ lines: () -> [CodePart]) -> [CodePart] {
    lines().map { $0.color(color) }
}

func highlight(_ highlight: Color? = Theme.Color.highlight, @LinesBuilder _ lines: () -> [CodePart]) -> [CodePart] {
    lines().map { $0.highlight(highlight) }
}

struct LineId: Hashable, Withable {
    let file: String
    let line: UInt
    var innerLineIndex: Int

    init(file: StaticString, line: UInt, innerLineIndex: Int = 0) {
        self.file = "\(file)"
        self.line = line
        self.innerLineIndex = innerLineIndex
    }

    var id: String {
        "\(file):\(line)+\(innerLineIndex)"
    }

    func innerLineIndex(_ index: Int) -> Self {
        with { $0.innerLineIndex = index }
    }
}

extension String {
    func highlight(_ color: Color? = Theme.Color.highlight, file: StaticString = #fileID, line: UInt = #line) -> [CodePart] {
        LinesBuilder.buildExpression(self, file: file, line: line)
            .map { $0.highlight(color) }
    }

    func color(_ color: Color? = Theme.Color.darkHighlight, file: StaticString = #fileID, line: UInt = #line) -> [CodePart] {
        LinesBuilder.buildExpression(self, file: file, line: line)
            .map { $0.color(color) }
    }
}

#Preview {
    CodeView {
        "One".color()
        "Two"
        if 10 > 3 {
            "Three".highlight(.yellow)
        }
    }
    .framed()
}
