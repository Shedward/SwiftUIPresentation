//
//  Code.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 09.10.2024.
//

import SwiftUI

struct CodeView: View, Withable {
    @Environment(\.space)
    var space: Space

    let code: Code
    var font: Font = Theme.Font.code

    init(code: Code, font: Font = Theme.Font.code) {
        self.code = code
        self.font = font
    }

    init(@CodeBuilder _ lines: () -> [Code.Line]) {
        self.code = Code(lines: lines)
    }

    var body: some View {
        HStack(alignment: .top, spacing: space.innerValue(2)) {
            VStack(alignment: .trailing, spacing: 0) {
                ForEach(code.lines, id: \.index) { line in
                    Text("\(line.index)")
                        .style(TextStyle(font: font, color: Theme.Color.contentTertiary))
                }
            }
            VStack(alignment: .leading, spacing: 0) {
                ForEach(code.lines, id: \.part.lineId) { line in
                    Text(line.part.text)
                        .style(TextStyle(font: font, color: Theme.Color.contentPrimary))
                        .background(line.part.highlight ?? .clear)
                }
            }
        }
    }

    func font(_ font: Font) -> Self {
        with { $0.font = font }
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

