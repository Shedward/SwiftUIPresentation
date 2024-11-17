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
            Text(slideshow.currentEpisode?.id ?? "-")
                .style(.debug)
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
