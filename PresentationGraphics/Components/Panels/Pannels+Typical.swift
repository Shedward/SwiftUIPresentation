//
//  Pannels+Typical.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 17.10.2024.
//

import SwiftUI

extension Panel {

    static func code(_ title: String = "Code", font: Font = Theme.Font.code, @CodeBuilder _ lines: @escaping () -> [Code.Line]) -> Panel {
        Panel(title) {
            CodeView(code: Code(lines: lines), font: font)
        }
    }

    static func viewTree(_ title: String = "View Tree", content: @escaping () -> Tree) -> Panel {
        Panel(title) {
            TreeView(content())
        }
    }

    static func renderTree(_ title: String = "Render Tree", content: @escaping () -> Tree) -> Panel {
        Panel(title) {
            TreeView(content())
                .relation(.renderTree)
        }
    }

    static func preview<Content: View>(_ title: String = "Preview", @ViewBuilder _ content: @escaping () -> Content) -> Panel {
        Panel(title) {
            content()
                .bordered()
        }
    }
}
