//
//  Pannels+Typical.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 17.10.2024.
//

import SwiftUI

extension Panel {

    static func code(_ title: String = "Code", @CodeBuilder _ lines: @escaping () -> [Code.Line]) -> Panel {
        Panel(title) {
            CodeView(lines)
        }
    }

    static func viewTree(_ title: String = "View Tree", content: @escaping () -> Tree) -> Panel {
        Panel(title) {
            TreeView(tree: content())
        }
    }

    static func preview<Content: View>(_ title: String = "Preview", @ViewBuilder _ content: @escaping () -> Content) -> Panel {
        Panel(title) {
            content()
                .bordered()
        }
    }
}
