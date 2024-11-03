//
//  AnotationsView.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 02.11.2024.
//

import SwiftUI

struct Annotation: Identifiable, Withable {
    let id: String
    let from: AnnotationId
    let to: AnnotationId
    var shape: AnnotationShape?
    var stroke: Color = .clear
    var fill: Color = Theme.Color.annotation.opacity(0.8)

    init(id: String, from: AnnotationId, to: AnnotationId) {
        self.id = id
        self.from = from
        self.to = to
    }

    init(from: AnnotationId, to: AnnotationId, file: StaticString = #fileID, line: UInt = #line) {
        self.id = LineId(file: file, line: line).id
        self.from = from
        self.to = to
    }

    func shape(_ shape: AnnotationShape) -> Self {
        with { $0.shape = shape }
    }

    func fill(_ fill: Color) -> Self {
        with { $0.fill = fill }
    }

    func stroke(_ stroke: Color) -> Self {
        with { $0.stroke = stroke }
    }
}

struct AnnotationShape {
    let shape: (_ from: CGRect, _ to: CGRect) -> any Shape

    func callAsFunction(from: CGRect, to: CGRect) -> AnyShape {
        AnyShape(shape(from, to))
    }

    static let line: AnnotationShape = AnnotationShape { from, to in
        Path { path in
            path.move(to: from.midRight)
            path.addLine(to: to.midRight)
        }
        .stroke(style: StrokeStyle(lineWidth: 1))
    }

    func stroke(style: StrokeStyle) -> Self {
        AnnotationShape { from, to in
            shape(from, to)
                .stroke(style: style)
        }
    }
}

struct AnnotationsView: View {

    let proxy: GeometryProxy
    let anchors: [AnnotationAnchor]
    let annotations: [Annotation]
    let padding = 0.5 * Space.min.value

    var body: some View {
        ForEach(annotations) { (annotation: Annotation) in
            if
                let fromAnchor = anchors.first(where: { $0.id == annotation.from }),
                let toAnchor = anchors.first(where: {$0.id == annotation.to })
            {
                let fromRect = proxy[fromAnchor.bounds].insetBy(dx: -padding, dy: -padding)
                let toRect = proxy[toAnchor.bounds].insetBy(dx: -padding, dy: -padding)

                (annotation.shape ?? .line)(from: fromRect, to: toRect)
                    .stroke(annotation.stroke)
                    .fill(annotation.fill)
            }
        }
    }
}

extension View {
    func annotate(@ArrayBuilder<Annotation> _ annotations: @escaping () -> [Annotation]) -> some View {
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
        Annotation(id: "A", from: "red", to: "green")
        Annotation(id: "B", from: "red", to: "blue")
        Annotation(id: "C", from: "red", to: "yellow")
    }
    .padding(32)
}
