//
//  ImportantInfo.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 03.11.2024.
//

import SwiftUI

struct Important: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }

    public var body: some View {
        Text(text)
    }
}
