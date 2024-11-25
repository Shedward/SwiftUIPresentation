//
//  S23_Observable.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 03.11.2024.
//

import SwiftUI

struct S24_ObservableObject: View, Slide {

    var episodes: [Episode] {
        e00 {
            "Еще упомяну про ObservableObject, StateObject и Published которые были до обзервабл"
            "Но так как мы уже закатили @Perceptable/@Observable"
            "Я не придумал кейса когда нам пришлось бы его использовать, поэтому подробно рассказывать не буду"
            "Упомяну только в двух словах что ..."
        }
    }

    var body: some View {
        TitleSubtitleLayout(title: "ObservableObject", subtitle: "Не актуально") {
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
