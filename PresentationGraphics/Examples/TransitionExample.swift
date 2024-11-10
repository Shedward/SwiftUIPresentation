//
//  TransitionExample.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 11.11.2024.
//

import SwiftUI

struct TransitionExample<T: Transition>: View {
    let transition: T

    @State private var flag = true

    var body: some View {
        VStack {
            Button("Toggle") {
                withAnimation { flag.toggle() }
            }
            if flag {
                Rectangle()
                    .frame(width: 100, height: 100)
                        .transition(transition)
            }
        }
    }
}

#Preview {
    TransitionExample(transition: .opacity)
}
