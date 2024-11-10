//
//  S33_Animatable.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 09.11.2024.
//

import SwiftUI

struct S35_Animatable3: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - Так же мы можем реализовывать протокол сами для 
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "Animatable") {
            Panels {
                Panel.code {
                    """
                    struct Shake: ViewModi!er, Animatable {
                        var numberOfShakes: Double
                        var animatableData: Double {
                            get { numberOfShakes }
                            set { numberOfShakes = newValue }
                        }
                         
                        func body(content: Content) -> some View {
                            content
                                .offset(x: -sin(numberOfShakes * 2 * .pi) * 30)
                            }
                        }
                    }
                    """
                }
            }
        }
    }
}
