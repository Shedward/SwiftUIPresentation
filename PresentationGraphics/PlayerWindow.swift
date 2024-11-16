//
//  ContentView.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 08.10.2024.
//

import SwiftUI

struct PlayerWindow: View {

    let slideshow: Slideshow

    var body: some View {
        SlidesPlayer(slideshow: slideshow)
            .background(Theme.Color.backgroundPrimary)
    }
}

#Preview {
    PlayerWindow(slideshow: .mock)
}

extension EnvironmentValues {
    @Entry
    var testValue: Bool = true
}


