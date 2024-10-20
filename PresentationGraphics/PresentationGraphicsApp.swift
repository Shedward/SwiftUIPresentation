//
//  PresentationGraphicsApp.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 08.10.2024.
//

import SwiftUI

@main
struct PresentationGraphicsApp: App {

    let slideshow = Slideshow {
        S00_Title()
        S01_Introduction()
        S02_Plan()

        S10_Structure()
        S11_View()
        S12_ViewTrees()
        S13_ViewBuilder()
        S14_TuppleView()
        S15_ConditionalContent()
        S16_ForEachView()

        MockSlide(id: "S01_Another")
        MockSlide(id: "S01_AndAnother")
        ComplexMockSlide()
    }

    var body: some Scene {
        WindowGroup {
            PlayerWindow(slideshow: slideshow)
        }
        .windowStyle(.hiddenTitleBar)
        Window("Clicker", id: "clicker") {
            ClickerWindow(slideshow: slideshow)
                .fixedSize()
        }
        .windowStyle(.hiddenTitleBar)
    }
}

