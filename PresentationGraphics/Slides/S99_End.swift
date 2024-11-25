//
//  S00_Title.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//

import SwiftUI

struct S99_End: View, Slide {

    var body: some View {
        TitleSubtitleLayout(title: "Конец") {
            BulletList {
                "Читайте книжку Thinking in SwiftUI"
                "Если хотите поиграться с презентацией - https://github.com/Shedward/SwiftUIPresentation"
            }
        }
    }
}

#Preview {
    S00_Title()
}
