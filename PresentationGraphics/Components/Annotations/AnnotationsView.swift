//
//  AnotationsView.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 02.11.2024.
//

import SwiftUI

struct AnnotationsView: View {

    let proxy: GeometryProxy
    let anchors: [AnnotationAnchor]
    let annotations: [AnyAnnotation]
    let padding = 0.5 * Space.min.value

    var body: some View {
        ForEach(annotations, id: \.id) { annotation in
            annotation.body(proxy: proxy, anchors: anchors)
        }
    }
}

extension View {
    func annotate(@ArrayBuilder<AnyAnnotation> _ annotations: @escaping () -> [AnyAnnotation]) -> some View {
        overlayPreferenceValue(AnnotationAnchorsKey.self) { anchors in
            GeometryReader { proxy in
                AnnotationsView(proxy: proxy, anchors: anchors, annotations: annotations())
                    .transition(.opacity)
            }
        }
    }
}

#Preview {
    HStack {
        VStack {
            Rectangle()
                .fill(Color.red)
                .annotatable("red")
            Rectangle()
                .fill(Color.blue)
                .annotatable("blue")
        }
        VStack {
            Rectangle()
                .fill(Color.green)
                .annotatable("green")
            Rectangle()
                .fill(Color.yellow)
                .annotatable("yellow")
        }
    }
    .annotate {
        LineAnnotation(id: "A", from: "red", to: "green")
        LineAnnotation(id: "B", from: "red", to: "blue")
        LineAnnotation(id: "C", from: "red", to: "yellow")
    }
    .padding(32)
}
