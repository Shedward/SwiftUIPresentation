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
        ScrollViewReader { proxy in
            List {
                ForEach(slideshow.slides, id: \.id) { slide in
                    Section {
                        ForEach(slide.episodes, id: \.id) { episode in
                            cell(slide: slide, episode: episode)
                        }
                    } header: {
                        header(for: slide)
                    }
                }
                .listStyle(PlainListStyle())
                .onKeysPress(.downArrow) {
                    slideshow.next()
                }
                .onKeysPress(.upArrow) {
                    slideshow.previous()
                }
            }
            .onChange(of: slideshow.position) { _, newValue in
                withAnimation {
                    proxy.scrollTo(slideshow.position, anchor: .center)
                }
            }
        }
    }

    func cell(slide: Slide, episode: Episode) -> some View {
        let position = SlideshowPosition(slideId: slide.id, episodeId: episode.id)
        return EpisodeCell(
            episode: episode,
            selected: position == slideshow.position
        )
        .contentShape(Rectangle())
        .onTapGesture {
            slideshow.goTo(position)
        }
        .id(position)
    }

    func header(for slide: Slide) -> some View {
        Text(slide.id)
            .style(
                TextStyle(font: Theme.Font.hSmall, color: Theme.Color.contentPrimary)
            )
            .padding(EdgeInsets(top: 16, leading: 8, bottom: 4, trailing: 8))
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
