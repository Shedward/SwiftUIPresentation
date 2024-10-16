//
//  Code.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 09.10.2024.
//

import SwiftUI

struct CodeView: View {
    @Environment(\.space)
    var space: Space

    let code: Code

    init(_ code: Code) {
        self.code = code
    }

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(code.lines, id: \.index) { line in
                HStack(spacing: space.innerValue(2)) {
                    Text("\(line.index)")
                        .style(.code.color(line.part.highlight ?? Theme.Color.contentTertiary))
                    Text(line.part.text)
                        .style(.code)
                        .background(line.part.highlight ?? .clear)
                }
            }
        }
    }
}

extension CodeView {
    init(@LinesBuilder _ lines: () -> [Code.Line]) {
        self.init(Code(lines: lines))
    }
}

#Preview {
    CodeView {
        "VStack {"
        "   Text(\"Hello World\")"
        "       .multilineTextAlignment(.leading)"
        "       .monospaced()"
        "       .padding()"
        "}"
    }
    .space(.s2)
    .padding()
}

