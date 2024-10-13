//
//  SectionTitle.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//

import SwiftUI

struct SectionTitleLayout: View {
    let text: String

    var body: some View {
        Text(text)
            .style(.title)
    }
}
