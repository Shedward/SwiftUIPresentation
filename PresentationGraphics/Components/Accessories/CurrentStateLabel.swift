//
//  InitialStateLabel.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 30.10.2024.
//

import SwiftUI

struct CurrentStateLabel: View {
    let name: String
    let initialValue: String

    var body: some View {
        Label {
            HStack {
                Text("\(name)")
                Text("=")
                    .style(
                        font: Theme.Font.captionSmall,
                        color: Theme.Color.contentSecondary
                    )
                Text("\(initialValue)")
            }
        } icon: {
            Image(systemName: "shippingbox")
        }
        .style(.caption)
    }
}

#Preview {
    CurrentStateLabel(name: "count", initialValue: "0")
        .padding()
}
