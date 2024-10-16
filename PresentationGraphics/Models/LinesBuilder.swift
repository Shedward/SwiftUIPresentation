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

    static func buildExpression(_ expression: String) -> [CodePart] {
        expression.split(separator: "\n").map { CodePart(String($0)) }
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
    var id: String?
    var text: String
    var highlight: Color?
    var color: Color?
    var anotationID: String?

    init(_ text: String) {
        self.text = text
    }

    func highlight(_ highlight: Color?) -> Self {
        with { $0.highlight = highlight }
    }

    func color(_ color: Color?) -> Self {
        with { $0.color = color }
    }

    func anotationID(_ anotationID: String?) -> Self {
        with { $0.anotationID = anotationID }
    }

    func id(_ id: String) -> Self {
        with { $0.id = id }
    }
}

func color(_ color: Color? = Theme.Color.darkHighlight, @LinesBuilder _ lines: () -> [CodePart]) -> [CodePart] {
    lines().map { $0.color(color) }
}

func highlight(_ highlight: Color? = Theme.Color.highlight, @LinesBuilder _ lines: () -> [CodePart]) -> [CodePart] {
    lines().map { $0.highlight(highlight) }
}

extension String {
    func id(_ id: String) -> [CodePart] {
        LinesBuilder.buildExpression(self)
            .enumerated()
            .map { index, part in part.id("\(id)-\(index)") }
    }

    func highlight(_ color: Color? = Theme.Color.highlight) -> [CodePart] {
        LinesBuilder.buildExpression(self)
            .map { $0.highlight(color) }
    }

    func anotationId(_ anotationID: String?) -> [CodePart] {
        LinesBuilder.buildExpression(self)
            .map { $0.anotationID(anotationID) }
    }

    func color(_ color: Color? = Theme.Color.darkHighlight) -> [CodePart] {
        LinesBuilder.buildExpression(self)
            .map { $0.color(color) }
    }
}

#Preview {
    CodeView {
        "One".color()
        "Two"
            .id("Second Parameter")
        if 10 > 3 {
            "Three".highlight(.yellow)
        }
    }
    .framed()
}
