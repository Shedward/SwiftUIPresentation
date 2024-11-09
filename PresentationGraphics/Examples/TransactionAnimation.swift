//
//  TransactionAnimation.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

struct TransactionAnimation: View {

    @State
    var offset: CGFloat = 50

    var body: some View {

        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .offset(x: offset)

            Button("Animate") {
                var transaction = Transaction()
                transaction.animation = .easeIn(duration: 0.25)
                withTransaction(transaction) {
                    offset = 100
                }
            }
        }
    }
}

#Preview {
    TransactionAnimation()
}
