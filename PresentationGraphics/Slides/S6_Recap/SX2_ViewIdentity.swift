//
//  SX2_ViewIdentity.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 25.11.2024.
//

import SwiftUI

struct SX2_ViewIdentity: View, Slide {
    let section: Int

    var id: String {
        "S\(section)2_ViewIdentity"
    }

    var episodes: [Episode] {
        e00 {
            "⚠️ Важная идея - View Identity"
        }
    }

    var body: some View {
        ImportantLayout("Идентичность вьюх") {
            "Идентичность определяется путем из id по которому можно пройти к вьюхе"
        }
    }
}
