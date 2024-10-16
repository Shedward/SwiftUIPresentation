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
    var nextEpisodeIndex: Int = 0

    var currentSlide: Slide? {
        guard slides.indices.contains(currentIndex) else {
            return nil
        }
        return slides[currentIndex]
    }

    var currentEpisodeId: String? {
        guard currentSlide?.episodes.indices.contains(nextEpisodeIndex - 1) ?? false else {
            return nil
        }
        return currentSlide?.episodes[nextEpisodeIndex - 1].id
    }

    var nextEpisode: Episode? {
        guard currentSlide?.episodes.indices.contains(nextEpisodeIndex) ?? false else {
            return nil
        }
        return currentSlide?.episodes[nextEpisodeIndex]
    }

    init(@ArrayBuilder<Slide> slides: () -> [Slide]) {
        let slides = slides()
        self.slides = slides
    }

    func goToBegining() {
        currentIndex = 0
        nextEpisodeIndex = 0
    }

    func next() {
        if currentSlide?.episodes.indices.contains(nextEpisodeIndex) ?? false {
            currentSlide?.episodes[nextEpisodeIndex].action()
            nextEpisodeIndex += 1
        } else {
            nextSlide()
        }
    }

    func nextSlide() {
        if slides.indices.contains(currentIndex + 1) {
            currentIndex += 1
            nextEpisodeIndex = 0
        }
    }

    func previous() {
        if currentSlide?.episodes.indices.contains(nextEpisodeIndex - 1) ?? false {
            currentSlide?.episodes[nextEpisodeIndex - 1].action()
            nextEpisodeIndex -= 1
        } else {
            previousSlide()
        }
    }

    func previousSlide() {
        if slides.indices.contains(currentIndex - 1) {
            currentIndex -= 1
            nextEpisodeIndex = 0
        }
    }
}
