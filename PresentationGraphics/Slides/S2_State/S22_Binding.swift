//
//  S21_StateModifier4.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 02.11.2024.
//

import SwiftUI

struct S22_Binding: View, Slide {

    var episodes: [Episode] {
        e00(
            """
            - Дальше биндинг
            - Биндинг мы используем когда у нас есть состояние которое приходит снаружи и изменяется из нутри
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "@Binding") {
            Panels {
                Panel.code {
                    """
                    struct Counter: View {
                        
                        @Binding
                        var counter: Int
                    
                        var body: some View {
                        }
                    }
                    """
                }
            }
        }
    }
}
