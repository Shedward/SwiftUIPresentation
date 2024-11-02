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

    var title: String?

    var body: some View {
        VStack {
            if let title {
                Text(title)
                    .style(.caption)
            }
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
        }
        .padding()
    }
}

#Preview {
    Counter(count: .constant(0))
}
