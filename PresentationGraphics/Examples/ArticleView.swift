//
//  ArticleView.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 24.10.2024.
//

import SwiftUI

struct ArticleView: View {
    let title: String
    let text: String

    let showAuthors: Bool
    let authors: [String]

    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.title)
            Text(text)
                .font(.body)
            if showAuthors {
                ForEach(authors, id: \.self) { author in
                    Text(author)
                        .font(.caption)
                }
            } else {
                Text("Authors: \(authors.count)")
                    .font(.caption)
                    .foregroundStyle(Color.white)
                    .padding([.leading, .trailing], 8)
                    .background(Color.black)
                    .clipShape(Capsule())
            }
        }
        .foregroundStyle(.black)
        .padding()
        .frame(width: 200)
    }
}

#Preview {
    ArticleView(
        title: "Заголовок",
        text: "Описание статьи  для проверки переноса строк и прочего.",
        showAuthors: false,
        authors: [
            "Автор Авторович",
            "Редактор Редакторович"
        ]
    )
}
