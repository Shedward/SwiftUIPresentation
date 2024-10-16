//
//  Pannels+Typical.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 17.10.2024.
//

import SwiftUI

extension Panel {

    static func code(title: String = "Code", @LinesBuilder _ lines: @escaping () -> [Code.Line]) -> Panel {
        Panel(title) {
            CodeView(lines)
        }
    }

    static func viewTree(title: String = "View Tree", content: @escaping () -> Tree) -> Panel {
        Panel(title) {
            TreeView(tree: content())
        }
    }

    static func preview<Content: View>(title: String = "Preview", @ViewBuilder _ content: @escaping () -> Content) -> Panel {
        Panel(title) {
            content()
                .bordered()
        }
    }
}