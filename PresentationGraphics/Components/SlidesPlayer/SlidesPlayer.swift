//
//  SlidesPlayer.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//

import SwiftUI

struct SlidesPlayer: View {
    let currentSlide: String

    let slides: [Slide]

    init(currentSlide: String, @ArrayBuilder<Slide> slides: () -> [Slide]) {
        self.currentSlide = currentSlide
        self.slides = slides()
    }

    var body: some View {
        if let currentSlide = slides.first(where: { $0.id == currentSlide }) {
            currentSlide.content
        } else {
            SlideNotFound(currentSlide: currentSlide)
        }
    }
}

struct SlideNotFound: View {
    let currentSlide: String

    var body: some View {
        Text("Slide not found with id: \(currentSlide).")
            .style(.caption)
    }
}
