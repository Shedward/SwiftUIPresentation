//
//  S34_ImplicitExplicit.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 09.11.2024.
//

import SwiftUI

struct S36_Transitions3: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - Кастомный транзишн 
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "Transition") {
            Panels {
                Panel.code("До iOS 17") {
                    """
                    extension AnyTransition {
                        static func blur(radius: CGFloat) -> Self {
                            .modi!er(active: Blur(radius: 5), identity: Blur(radius: 0))
                        
                    }
                    """
                }

                Panel.code("После iOS 17") {
                    """
                    struct BlurTransition: Transition {
                     
                        var radius: CGFloat
                     
                        func body(content: Content, phase: TransitionPhase) -> some View {
                            content
                                .blur(radius: phase.isIdentity ? 0 : radius)
                            }
                    }
                    """
                }
            }
        }
    }
}
