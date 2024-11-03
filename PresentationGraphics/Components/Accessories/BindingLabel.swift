//
//  InitialStateLabel.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 30.10.2024.
//

import SwiftUI

struct BindingLabel: View {
    let name: String

    var body: some View {
        Label {
            Text("\(name)")
                .fixedSize()
        } icon: {
            Image(systemName: "binoculars")
        }
        .style(.caption)
    }
}

#Preview {
    InitialStateLabel(name: "count", initialValue: "0")
        .padding()
}
