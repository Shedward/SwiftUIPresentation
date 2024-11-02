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
                    .background(Theme.Color.backgroundPrimary)
                    .id(currentSlide.id)
                    .transition(.opacity)
                    .episode(slideshow.currentEpisode ?? e00)
            } else {
                ErrorView("Slide not found at \(slideshow.currentSlideIndex)")
            }
        }
        .animation(.snappy, value: slideshow.currentEpisode)
        .animation(.smooth, value: slideshow.currentSlideIndex)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .focusable(interactions: .edit)
        .focusEffectDisabled()
        .onKeysPress(.downArrow, .space) {
            slideshow.next()
        }
        .onKeysPress(.upArrow) {
            slideshow.previous()
        }
        .onKeysPress(.clear) {
            slideshow.goToBegining()
        }
    }
}
