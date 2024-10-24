//
//  S17_ViewBuilderIsNotACode.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 20.10.2024.
//

import SwiftUI

struct S19_ViewIdentity: View, Slide {

    var notes: String? {
        """
        - Немного про эти идентификаторы и жизненный цикл вьюх.
        """
    }

    var body: some View {
        TitleSubtitleLayout(title: "View Identity") {
            Panels {
                Panel.code {
                    
                }
            }
        }
    }
}
