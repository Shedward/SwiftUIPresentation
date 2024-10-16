//
//  Slideshow.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 09.10.2024.
//

import Observation

@Observable @MainActor
final class Slideshow {

    let slides: [Slide]
    var currentIndex: Int = 0
    var nextStepIndex: Int = 0

    var currentSlide: Slide? {
        guard slides.indices.contains(currentIndex) else {
            return nil
        }
        return slides[currentIndex]
    }

    var currentStepId: String? {
        guard currentSlide?.steps.indices.contains(nextStepIndex - 1) ?? false else {
            return nil
        }
        return currentSlide?.steps[nextStepIndex - 1].id
    }

    var nextStep: Step? {
        guard currentSlide?.steps.indices.contains(nextStepIndex) ?? false else {
            return nil
        }
        return currentSlide?.steps[nextStepIndex]
    }

    init(@ArrayBuilder<Slide> slides: () -> [Slide]) {
        let slides = slides()
        self.slides = slides
    }

    func goToBegining() {
        currentIndex = 0
        nextStepIndex = 0
    }

    func next() {
        if currentSlide?.steps.indices.contains(nextStepIndex) ?? false {
            currentSlide?.steps[nextStepIndex].action()
            nextStepIndex += 1
        } else {
            nextSlide()
        }
    }

    func nextSlide() {
        if slides.indices.contains(currentIndex + 1) {
            currentIndex += 1
            nextStepIndex = 0
        }
    }

    func previous() {
        if currentSlide?.steps.indices.contains(nextStepIndex - 1) ?? false {
            currentSlide?.steps[nextStepIndex - 1].action()
            nextStepIndex -= 1
        } else {
            previousSlide()
        }
    }

    func previousSlide() {
        if slides.indices.contains(currentIndex - 1) {
            currentIndex -= 1
            nextStepIndex = 0
        }
    }
}
