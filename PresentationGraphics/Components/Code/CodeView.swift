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
        HStack(alignment: .top, spacing: space.innerValue(2)) {
            VStack(alignment: .trailing, spacing: 0) {
                ForEach(code.lines, id: \.index) { line in
                    Text("\(line.index)")
                        .style(.code.color(Theme.Color.contentTertiary))
                }
            }
            VStack(alignment: .leading, spacing: 0) {
                ForEach(code.lines, id: \.part.lineId) { line in
                    Text(line.part.text)
                        .style(.code.color(line.part.color ?? Theme.Color.contentPrimary))
                        .background(line.part.highlight ?? .clear)
                }
            }
        }
    }
}

extension CodeView {
    init(@CodeBuilder _ lines: () -> [Code.Line]) {
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

