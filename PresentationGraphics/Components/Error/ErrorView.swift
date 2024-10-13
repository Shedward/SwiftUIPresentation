//
//  ErrorView.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//

import SwiftUI

struct ErrorView: View {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle")
            Text(message)
        }
        .style(.debug)
        .framed(stroke: Theme.Color.debug, strokeWidth: 2)
        .space(.s3)
    }
}

#Preview {
    ErrorView("Error View")
}
