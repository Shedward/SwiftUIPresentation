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
                        .style(.code.color(Theme.Color.contentTertiary))
                    Text(line.text)
                        .style(.code)
                }
            }
        }
    }
}

extension CodeView {
    
}

#Preview {
    CodeView(
        Code("""
            VStack {
                Text(text)
                    .multilineTextAlignment(.leading)
                    .monospaced()
                    .padding()
            }
            """)
    )
    .space(.s2)
    .padding()
}

