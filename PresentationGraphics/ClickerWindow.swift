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
        List {
            ForEach(slideshow.slides, id: \.id) { slide in
                Section {
                    ForEach(slide.episodes, id: \.id) { episode in
                        let position = SlideshowPosition(slideId: slide.id, episodeId: episode.id)
                        EpisodeCell(
                            episode: episode,
                            selected: position == slideshow.position
                        )
                        .onTapGesture {
                            slideshow.goTo(position)
                        }
                    }
                } header: {
                    Text(slide.id)
                        .style(
                            TextStyle(font: Theme.Font.hSmall, color: Theme.Color.contentPrimary)
                        )
                        .padding(EdgeInsets(top: 16, leading: 8, bottom: 4, trailing: 8))
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct EpisodeCell: View {
    let episode: Episode
    let selected: Bool

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(episode.id)
                .style(.caption)
                .bold()
            Text(episode.notes ?? "")
                .style(.bodySmall)
            Spacer()
        }
        .padding(.horizontal, 8)
        .listRowBackground(selected ? Theme.Color.highlight.opacity(0.5) : nil)
    }
}

#Preview {
    EpisodeCell(
        episode: Episode(
            "e05",
            notes: """
            - One
            - Two 
            - Three
            """
        ),
        selected: true
    )
}
