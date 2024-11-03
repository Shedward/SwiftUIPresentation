//
//  BindingCounter.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 03.11.2024.
//

import SwiftUI

struct BindingCounter: View {

    @State
    var count: Int = 0

    var body: some View {
        VStack {
            Counter(count: $count)
            Counter(count: $count)
            Button("Reset") {
                count = 0
            }
        }
    }
}
