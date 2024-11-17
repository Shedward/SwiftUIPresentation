//
//  RectIllustration.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 16.11.2024.
//

import SwiftUI

struct FrameIllustration: Illustration {
    let id: String
    let frame: CGRect

    var position: CGPoint {
        frame.origin
    }

    init(frame: CGRect, _ file: StaticString = #fileID, line: UInt = #line) {
        self.id = LineId(file: file, line: line).id
        self.frame = frame
    }

    func body() -> some View {
        Rectangle()
            .fill(Color.clear)
            .stroke(Theme.Color.contentPrimary, style: StrokeStyle(lineWidth: 1))
            .frame(width: frame.width, height: frame.height)
            .edgeCallout {
                FrameDescription(frame: frame)
                    .edgeCalloutPosition(.top)
            }
    }
}

struct FrameDescription: View {
    let frame: CGRect

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("x: \(Int(frame.origin.x)) y: \(Int(frame.origin.y))")
            Text("w: \(Int(frame.size.width)) h: \(Int(frame.size.height))")
        }
        .style(.codeExtraSmall)
        .frame(width: frame.width, alignment: .bottomLeading)
    }
}
