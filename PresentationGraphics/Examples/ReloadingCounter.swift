//
//  ReloadingCounter.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 03.11.2024.
//

import SwiftUI

struct ReloadingCounter: View {

    @State
    var externalCounter: Int = 0

    @State
    var viewId: UUID = .init()

    var body: some View {
        SpacedVStack {
            Counter(count: $externalCounter, title: "External Counter")
            Button("Reload Counter") {
                viewId = UUID()
            }

            CounterWithInit(countFromInit: externalCounter)
                .id(viewId)
                .framed(fill: Theme.Color.backgroundPrimary)
        }
        .space(maxSpace: .s3)
    }
}
