//
//  S23_Observable.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 03.11.2024.
//

import SwiftUI

struct S24_ObservableObject: View, Slide {

    var episodes: [Episode] {
        e00("""
            - Еще есть ObservableObject, StateObject и Published
            - Но так как мы уже закатили @Perceptable/@Observable рассказывать не буду
            """)
    }

    var body: some View {
        TitleSubtitleLayout(title: "ObservableObject") {
            Panels {
                Panel.code {
                    """
                    final class Model: ObservableObject {
                        @Published var value = 0
                    }
                     
                    struct Counter: View {
                        @StateObject
                        private var model = Model()
                         
                        var body: some View {
                            Button("Increment: \\(model.value)") {
                                model.value += 1
                            }
                        }
                    }
                    """
                }
            }
        }
    }
}
