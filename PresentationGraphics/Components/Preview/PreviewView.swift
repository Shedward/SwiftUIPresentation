
//
//  PreviewView.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

public struct PreviewView<Content: View>: View {
    private let content: Content

    @State
    private var instanceId: Int = 0

    init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        VStack {
            content
                .bordered()
                .id(instanceId)
            Button {
                instanceId += 1
            } label: {
                Image(systemName: "arrow.circlepath")
            }
        }
    }
}
