//
//  GeometryReaderExample.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 17.11.2024.
//

import SwiftUI

public struct GeometryReaderExample: View {
    public var body: some View {
        GeometryReader { proxy in
            Text("\(proxy.size)")
        }
    }
}

#Preview {
    GeometryReaderExample()
        .frame(width: 300, height: 300)
}
