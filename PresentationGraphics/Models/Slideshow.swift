//
//  Slideshow.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 09.10.2024.
//

import Observation

@Observable
final class Slideshow {

    let slides: [Slide]
    var currentIndex: Int = 0

    var currentSlide: Slide? {
        guard slides.indices.contains(currentIndex) else {
            return nil
        }
        return slides[currentIndex]
    }

    init(@ArrayBuilder<Slide> slides: () -> [Slide]) {
        let slides = slides()
        self.slides = slides
    }

    func goToBegining() {
        currentIndex = 0
    }

    func next(step: Int = 1) {
        if slides.indices.contains(currentIndex + step) {
            currentIndex = currentIndex + step
        }
    }

    func previous() {
        next(step: -1)
    }
}
