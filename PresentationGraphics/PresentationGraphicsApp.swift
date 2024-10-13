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
        MockSlide(id: "S01_Another")
        MockSlide(id: "S01_AndAnother")
    }

    var body: some Scene {
        WindowGroup {
            PlayerWindow(slideshow: slideshow)
        }
        .windowStyle(.hiddenTitleBar)
    }
}

