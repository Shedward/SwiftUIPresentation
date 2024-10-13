//
//  SlidesPlayer.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//

import SwiftUI

struct SlidesPlayer: View {
    let slideshow: Slideshow

    init(slideshow: Slideshow) {
        self.slideshow = slideshow
    }

    var body: some View {
        Group {
            if let currentSlide = slideshow.currentSlide {
                currentSlide.content
                    .id(currentSlide.id)
                    .transition(.opacity)
            } else {
                ErrorView("Slide not found at \(slideshow.currentIndex)")
            }
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .focusable(interactions: .edit)
            .focusEffectDisabled()
            .onKeysPress(.downArrow, .space) {
                withAnimation {
                    slideshow.next()
                }
            }
            .onKeysPress(.upArrow) {
                withAnimation {
                    slideshow.previous()
                }
            }
            .onKeysPress(.clear) {
                slideshow.goToBegining()
            }
    }
}
