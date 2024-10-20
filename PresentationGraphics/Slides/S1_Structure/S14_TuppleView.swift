//
//  S14_TuppleView.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 19.10.2024.
//

import SwiftUI

struct S14_TuppleView: View, Slide {

    @Environment(\.episode)
    var episode: String

    var episodes: [Episode] {
        "e01-комбинация-туплов"
        "e02-group"
    }

    var body: some View {
        TitleSubtitleLayout(title: "TuppleView") {
            Panels {
                Panel.code("type(of: content)") {
                    """
                    TupleView<(
                        Image,
                        Text, 
                        Image
                    )>
                    """
                }

                Panel.code {
                    "var body: some View {"
                    "    VStack {"
                    "        content"
                    "        content2"
                        .showIf(episode, after: "e01-комбинация-туплов")
                    "    }"
                    "}"
                    
                    """
                        
                    @ViewBuilder
                    var content: some View {
                        Image(systemName: "house")
                        Text("Hello")
                    
                        Image(systemName: "hand.wave")
                    }    
                    """

                    """
                        
                    var content2: some View {
                        Image(systemName: "globe")
                        Text("World")
                        Image(systemName: "hand.wave")
                    }  
                    """.showIf(episode, after: "e01-комбинация-туплов")
                }

                Panel.viewTree {
                    Tree("VStack") {
                        Tree("TuppleView") {
                            Tree("HouseImage", title: "Image")
                            Tree("Text")
                            Tree("GlobeImage", title: "Image")
                        }
                    }
                }
            }
        }
    }
}
