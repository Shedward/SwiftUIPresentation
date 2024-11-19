//
//  MatchedGeometryExample.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 19.11.2024.
//

import SwiftUI

struct MatchedGeometryExample: View {

    @Namespace
    var namespace

    @State
    var matchedId: Int = 0

    var body: some View {
        VStack {
            Grid(horizontalSpacing: 16, verticalSpacing: 16) {
                GridRow {
                    Text("Some text")
                        .matchedGeometryEffect(id: 0, in: namespace)
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 40, height: 40)
                        .matchedGeometryEffect(id: 1, in: namespace)
                }
                GridRow {
                    Image(systemName: "gamecontroller")
                        .matchedGeometryEffect(id: 2, in: namespace)
                    Text("Another text")
                        .matchedGeometryEffect(id: 3, in: namespace)
                }
            }
            .overlay {
                Rectangle()
                    .fill(Color.clear)
                    .stroke(.green, style: StrokeStyle(lineWidth: 2))
                    .matchedGeometryEffect(id: matchedId % 5, in: namespace, isSource: false)
                    .animation(.default, value: matchedId)
            }
            .padding()

            Button("Next") {
                matchedId += 1
            }
        }
    }
}

#Preview {
    MatchedGeometryExample()
}
