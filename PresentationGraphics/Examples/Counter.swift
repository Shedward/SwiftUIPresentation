//
//  Counter.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 30.10.2024.
//

import SwiftUI

struct Counter: View {
    @Binding
    var count: Int

    var body: some View {
        HStack {
            Text("\(count)")
            Button {
                count -= 1
            } label: {
                Image(systemName: "minus")
            }
            Button {
                count += 1
            } label: {
                Image(systemName: "plus")
            }
        }
        .padding()
    }
}

#Preview {
    Counter(count: .constant(0))
}
