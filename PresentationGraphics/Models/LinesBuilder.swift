//
//  LinesBuilder.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 16.10.2024.
//

import SwiftUI

@resultBuilder
enum LinesBuilder {
    static func buildExpression(_ expression: String) -> [CodePart] {
        [CodePart(expression)]
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
    var anotationID: String?

    init(_ text: String) {
        self.text = text
    }

    func highlight(_ highlight: Color?) -> Self {
        with { $0.highlight = highlight }
    }

    func anotationID(_ anotationID: String?) -> Self {
        with { $0.anotationID = anotationID }
    }

    func id(_ id: String) -> Self {
        with { $0.id = id }
    }
}

extension String {
    func id(_ id: String) -> CodePart {
        CodePart(self)
            .id(id)
    }

    func highlight(_ color: Color? = Theme.Color.highlight) -> CodePart {
        CodePart(self)
            .highlight(color)
    }

    func anotationId(_ anotationID: String?) -> CodePart {
        CodePart(self)
            .anotationID(anotationID)
    }
}

#Preview {
    CodeView {
        "One"
        "Two"
            .id("Second Parameter")
        if 10 > 3 {
            "Three".highlight(.yellow)
        }
    }
}
