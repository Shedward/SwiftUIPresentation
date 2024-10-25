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
//        S00_Title()
//        S01_Introduction()
//        S02_Plan()
//
//        S10_Structure()
//        S11_View()
//        S12_ViewTrees()
//        S13_ViewBuilder()
//        S14_TuppleView()
//        S15_ConditionalContent()
//        S16_ForEachView()
//        S17_ViewBuilderDSL()
        S18_RenderTree()
        S18_RenderTree2()
        S18_RenderTree3()
        S18_RenderTree4()
        S18_RenderTree5()
        S19_Recap()
    }

    var body: some Scene {
        WindowGroup {
            PlayerWindow(slideshow: slideshow)
                .colorScheme(.light)
        }
        .windowStyle(.hiddenTitleBar)

        Window("Clicker", id: "clicker") {
            ClickerWindow(slideshow: slideshow)
                .fixedSize()
                .colorScheme(.light)
        }
        .windowStyle(.hiddenTitleBar)
    }
}

