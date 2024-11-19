//
//  S30_Animations.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

struct S45_GeometryReader5: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - Но вообще для передачи размеров и фреймов существует более удобный механизм
            """
        )
        e01(
            """
            - Затем мы можем использовать это так 
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "GeometryReader", subtitle: "Anchors") {
            Panels {
                Panel.code("PreferenceKay") {
                    """
                    struct AnnotationAnchor {
                        let id: AnnotationId
                        let bounds: Anchor<CGRect>
                    }

                    struct AnnotationAnchorsKey: PreferenceKey {
                        static var defaultValue: [AnnotationAnchor] = []

                        static func reduce(
                            value: inout [AnnotationAnchor], 
                            nextValue: () -> [AnnotationAnchor]
                        ) {
                            value = nextValue() + value
                        }
                    }
                    """
                }
                .hideIf(episode, after: e01)

                Panel.code("Оверлей") {
                    """
                    func annotatable(_ id: String) -> some View {
                    """
                    """
                        anchorPreference(
                    """
                        .highlight()
                    """
                                key: AnnotationAnchorsKey.self,
                                value: .bounds
                            ) { bounds in
                                [AnnotationAnchor(id: id, bounds: bounds)]
                            }
                        }
                         
                        func highlightAnnotations() -> some View {
                        """
                        """
                            overlayPreferenceValue(
                        """
                            .highlight()
                        """
                            AnnotationAnchorsKey.self,
                            alignment: .topLeading
                        ) { anchors in
                                GeometryReader { proxy in
                                    ForEach(anchors, id: \\.id) { anchor in
                                        let frame = proxy[anchor.bounds]
                                        Rectangle()
                                            .fill(Color.green.opacity(50))
                                            .frame(width: 
                                                frame.width, 
                                                height: frame.height
                                            )
                                            .position(frame.origin)
                                    }
                                }
                            }
                        }
                    }
                    """
                }

                Panel.code("Использование") {
                    """
                    Panel.preview {
                        VStack {
                            Text("Title")
                                .annotatable("title")
                            Text("Subtitle")
                            HStack {
                                Image(systemName: "person.circle")
                                    .annotatable("icon")
                                Image(systemName: "star")
                            }
                        }
                        .highlightAnnotations()
                    }
                    """
                }
                .showIf(episode, at: e01)

                Panel.preview {
                    VStack {
                        Text("Title")
                            .annotatable("title")
                        Text("Subtitle")
                        HStack {
                            Image(systemName: "person.circle")
                                .annotatable("icon")
                            Image(systemName: "star")
                        }
                    }
                    .highlightAnnotations()
                }
                .showIf(episode, at: e01)
            }
        }
    }
}

extension View {
    func highlightAnnotations() -> some View {
        overlayPreferenceValue(AnnotationAnchorsKey.self) { anchors in
            GeometryReader { proxy in
                ForEach(anchors, id: \.id) { anchor in
                    let frame = proxy[anchor.bounds]
                    Rectangle()
                        .fill(Color.green.opacity(25))
                        .frame(width: frame.width, height: frame.height)
                        .position(frame.center)
                }
            }
        }
    }
}
