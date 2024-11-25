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
        S17_ViewBuilderDSL()
        S17_ViewBuilderDSL2()
        SX1_ViewTree(section: 1)
        SX2_ViewIdentity(section: 1)
        S18_RenderTree2()
        S18_RenderTree3()
        S18_RenderTree4()
        S18_RenderTree5()
        SX3_RenderTree(section: 1)
        S19_Lifecycle()
        SX3_ViewLifecycle(section: 1)
        S19_Questions()

        S20_State()
        S21_StateModifier()
        S21_StateModifier2()
        S21_StateModifier3()
        SX4_State(section: 2)
        S21_StateModifier4()
        S22_Binding()
        SX5_Binding(section: 2)
        S23_Observable()
        S23_Observable2()
        SX5_Observable(section: 2)
        S23_Observable3()
        S24_ObservableObject()
        S29_Questions()

        S50_DataFlow()
        S51_Environment()
        SX6_Environment(section: 5)
        S51_Environment2()
        S52_Preference()
        SX7_Preference(section: 5)
        S52_Preference2()
        S59_Questions()

        S30_Animations()
        S31_WhatIsAnimation()
        S32_Transaction()
        SX8_AnimationByTransaction(section: 3)
        S33_Animatable()
        S33_Animatable2()
        S34_ImplicitExplicit()
        S34_ImplicitExplicit2()
        S34_ImplicitExplicit3()
        S35_Animatable3()
        S36_Transitions()
        S36_Transitions2()
        S36_Transitions3()
        SX9_AnimationVsTransition(section: 3)
        S39_Questions()

        S40_Layout()
        S41_LayoutLogic()
        S42_LayoutProtocol()
        S43_UnitGeometry()
        SX10_LayoutIsNegotiation(section: 4)
        SX11_LayoutPositioning(section: 4)
        S43_LayoutModifiers()
        S44_Alignment()
        S44_Alignment2()
        SX12_Alignments(section: 4)
        S45_GeometryReader()
        S45_GeometryReader2()
        S45_GeometryReader3()
        S45_GeometryReader4()
        S45_GeometryReader5()
        SX13_GeometryReader(section: 4)
        S49_MatchedGeometryEffect()
        S49_MatchedGeometryEffect2()
        S49_Questions()

        S60_Recap()
        SX1_ViewTree(section: 6)
        SX2_ViewIdentity(section: 6)
        SX3_RenderTree(section: 6)
        SX3_ViewLifecycle(section: 6)
        SX4_State(section: 6)
        SX5_Binding(section: 6)
        SX5_Observable(section: 6)
        SX6_Environment(section: 6)
        SX7_Preference(section: 6)
        SX8_AnimationByTransaction(section: 6)
        SX9_AnimationVsTransition(section: 6)
        SX10_LayoutIsNegotiation(section: 6)
        SX11_LayoutPositioning(section: 6)
        SX12_Alignments(section: 6)
        SX13_GeometryReader(section: 6)
    }

    var body: some Scene {
        WindowGroup {
            PlayerWindow(slideshow: slideshow)
                .colorScheme(.light)
        }
        .windowStyle(.hiddenTitleBar)

        Window("Clicker", id: "clicker") {
            ClickerWindow(slideshow: slideshow)
                .colorScheme(.light)
        }

        Window("Debugger", id: "debugger") {
            DebugWindow()
        }
    }
}

