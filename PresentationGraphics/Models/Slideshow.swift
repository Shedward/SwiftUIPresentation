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
    var currentSlideIndex: Int = 0
    var currentEpisodeIndex: Int = 0

    var currentSlide: Slide? {
        guard slides.indices.contains(currentSlideIndex) else {
            return nil
        }
        return slides[currentSlideIndex]
    }

    var currentEpisode: Episode? {
        guard currentSlide?.episodes.indices.contains(currentEpisodeIndex) ?? false else {
            return nil
        }
        return currentSlide?.episodes[currentEpisodeIndex]
    }

    var position: SlideshowPosition {
        SlideshowPosition(
            slideId: currentSlide?.id ?? "",
            episodeId: currentEpisode?.id ?? ""
        )
    }

    init(@ArrayBuilder<Slide> slides: () -> [Slide]) {
        let slides = slides()
        self.slides = slides
    }

    func goToBegining() {
        currentSlideIndex = 0
        currentEpisodeIndex = 0
    }

    func goTo(_ position: SlideshowPosition) {
        guard let slideIndex = slides.firstIndex(where: { $0.id == position.slideId }) else {
            return
        }
        guard let episodeIndex = slides[slideIndex].episodes.firstIndex(where: { $0.id == position.episodeId }) else {
            return
        }

        currentSlideIndex = slideIndex
        currentEpisodeIndex = episodeIndex
    }

    func next() {
        if currentSlide?.episodes.indices.contains(currentEpisodeIndex + 1) ?? false {
            currentEpisodeIndex += 1
        } else {
            nextSlide()
        }
    }

    func nextSlide() {
        if slides.indices.contains(currentSlideIndex + 1) {
            currentSlideIndex += 1
            currentEpisodeIndex = 0
        }
    }

    func previous() {
        if currentSlide?.episodes.indices.contains(currentEpisodeIndex - 1) ?? false {
            currentEpisodeIndex -= 1
        } else {
            previousSlide()
        }
    }

    func previousSlide() {
        let previousSlideIndex = currentSlideIndex - 1
        if slides.indices.contains(previousSlideIndex) {
            currentSlideIndex = previousSlideIndex
            currentEpisodeIndex = slides[previousSlideIndex].episodes.count - 1
        }
    }

    func validate() {
        let duplicateIds = Dictionary(grouping: slides, by: \.id)
            .compactMap { id, slides in
                if slides.count > 1 {
                    id
                } else {
                    nil
                }
            }

        if !duplicateIds.isEmpty {
            print("⚠️ Обнаружены дубликаты слайдов: \(duplicateIds)")
        }
    }
}

struct SlideshowPosition: Hashable {
    let slideId: String
    let episodeId: String
}
