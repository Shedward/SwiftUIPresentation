//
//  ControslWindow.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//

import SwiftUI

struct ClickerWindow: View {
    let slideshow: Slideshow

    init(slideshow: Slideshow) {
        self.slideshow = slideshow
    }

    var body: some View {
        VStack {
            Text(slideshow.currentSlide?.id ?? "-")
                .style(.debug)
            Text(slideshow.nextEpisode?.id ?? "-")
                .style(.debug)
                .opacity(0.8)
            HStack {
                Button {
                    slideshow.previous()
                } label: {
                    Image(systemName: "backward.fill")
                }
                Button {
                    slideshow.next()
                } label: {
                    Image(systemName: "forward.fill")
                }
            }
        }
    }
}
