//
//  MatchedGeometryTransitionExample.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 19.11.2024.
//

import SwiftUI

struct MatchedGeometryTransitionExample: View {

    @Namespace
    var namespace

    @State
    var isCircle: Bool = true

    var body: some View {
        VStack {
            if isCircle {
                Text("Hello")
                    .frame(maxWidth: .infinity)
                    .transition(.opacity)
                    .matchedGeometryEffect(id: "text", in: namespace)
                Circle()
                    .frame(width: 50, height: 50)
                    .transition(.blurReplace)
                    .matchedGeometryEffect(id: "figure", in: namespace)
            } else {
                Rectangle()
                    .frame(width: 50, height: 50)
                    .transition(.blurReplace)
                    .matchedGeometryEffect(id: "figure", in: namespace)
                Text("Bye")
                    .frame(maxWidth: .infinity)
                    .transition(.opacity)
                    .matchedGeometryEffect(id: "text", in: namespace)
            }

            Button("Toggle") {
                withAnimation {
                    isCircle.toggle()
                }
            }
        }
        .frame(width: 200)
        .padding()
    }
}

#Preview {
    MatchedGeometryTransitionExample()
}
