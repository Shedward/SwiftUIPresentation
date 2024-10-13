//
//  ContentView.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 08.10.2024.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        SlidesPlayer(currentSlide: "S00_Title") {

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Theme.Color.backgroundPrimary)
    }
}

#Preview {
    ContentView()
}
