//
//  AnimatableNodes.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 09.11.2024.
//

import SwiftUI

struct AnimatableNodes: View {

    @State
    var finished: Bool = false

    var body: some View {

        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .offset(x: finished ? 0 : 50)

            Text("Globe")
                .opacity(finished ? 1 : 0)

            Button("Animate") {
                withAnimation {
                    finished = true
                }
            }
        }
    }
}
