//
//  PresentationGraphicsApp.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 08.10.2024.
//

import SwiftUI

@main
struct PresentationGraphicsApp: App {

    @State
    var slideshow = Slideshow {
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
//        S18_RenderTree()
//        S18_RenderTree2()
//        S18_RenderTree3()
//        S18_RenderTree4()
//        S18_RenderTree5()
//        S18_RenderTree6()
//        S19_Recap()
//
//        S20_State()
//        S21_StateModifier()
//        S21_StateModifier2()
//        S21_StateModifier3()
//        S21_StateModifier4()
//        S22_Binding()
//        S23_Observable()
//        S23_Observable2()
//        S23_Observable3()
//        S24_ObservableObject()
//
//        S30_Animations()
//        S31_WhatIsAnimation()
//        S32_Transaction()
//        S33_Animatable()
//        S33_Animatable2()
//        S34_ImplicitExplicit()
//        S34_ImplicitExplicit2()
//        S34_ImplicitExplicit3()
//        S35_Animatable3()
//        S36_Transitions()
//        S36_Transitions2()
//        S36_Transitions3()

//        S40_Layout()
//        S41_LayoutLogic()
//        S42_LayoutProtocol()
//        S43_UnitGeometry()
//        S43_LayoutModifiers()
//        S44_Alignment()
        S44_Alignment2()
        S45_GeometryReader()
        S45_GeometryReader2()
        S45_GeometryReader3()
        S45_GeometryReader4()
        S48_Anchors()
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

        Window("Debugger", id: "debugger") {
            DebugWindow()
        }
    }
}

