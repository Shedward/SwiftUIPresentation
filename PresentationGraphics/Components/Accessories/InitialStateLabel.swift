//
//  InitialStateLabel.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 30.10.2024.
//

import SwiftUI

struct InitialStateLabel: View {
    let name: String
    let initialValue: String

    var body: some View {
        Label {
            HStack {
                Text("\(name)")
                Text("from \(initialValue)")
                    .style(
                        font: Theme.Font.captionSmall,
                        color: Theme.Color.contentSecondary
                    )
            }
        } icon: {
            Image(systemName: "hexagon")
        }
        .style(.caption)
    }
}

#Preview {
    InitialStateLabel(name: "count", initialValue: "0")
        .padding()
}
