//
//  InitialStateLabel.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 30.10.2024.
//

import SwiftUI

struct CurrentStateLabel: View {
    let name: String
    let value: String

    var body: some View {
        Label {
            HStack {
                Text("\(name)")
                Text("=")
                    .style(
                        font: Theme.Font.captionSmall,
                        color: Theme.Color.contentSecondary
                    )
                Text("\(value)")
            }
        } icon: {
            Image(systemName: "shippingbox")
        }
        .style(.caption)
    }
}

#Preview {
    CurrentStateLabel(name: "count", value: "0")
        .padding()
}
