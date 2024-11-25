//
//  SX2_ViewIdentity.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 25.11.2024.
//

import SwiftUI

struct SX3_ViewLifecycle: View, Slide {
    let section: Int

    var id: String {
        "S\(section)2_ViewLifecycle"
    }

    var episodes: [Episode] {
        e00 {
            "⚠️ Важная идея - View Lifecycle"
        }
    }

    var body: some View {
        ImportantLayout("Жизненый цикл вью определяется ее существованием в дереве") {
            "onAppear"
            "onChange"
            "onDissapear"
        }
    }
}
