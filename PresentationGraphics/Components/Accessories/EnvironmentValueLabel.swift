//
//  InitialStateLabel.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 30.10.2024.
//

import SwiftUI

struct EnvironmentValueLabel: View {
    var name: String?
    let value: String
    var mode: Mode = .normal

    var body: some View {
        Label {
            VStack(alignment: .leading) {
                if let name {
                    Text("\(name)")
                        .bold()
                }
                Text("\(value)")
            }
        } icon: {
            Image(systemName: "globe")
        }
        .style(mode.style)
    }

    enum Mode {
        case normal
        case used
        case rewritten

        var style: TextStyle {
            switch self {
            case .normal:
                .caption
            case .used:
                .caption.color(Theme.Color.contentPrimary)
            case .rewritten:
                .caption.color(Theme.Color.tintPrimary)
            }
        }
    }
}

#Preview {
    EnvironmentValueLabel(name: "count", value: "0")
        .padding()
}
