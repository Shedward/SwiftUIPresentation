//
//  Counter.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 30.10.2024.
//

import SwiftUI

struct CounterWithInit: View {
    @State
    var count: Int

    init(countFromInit: Int) {
        self.count = countFromInit
    }

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
    CounterWithInit(countFromInit: 2)
}
