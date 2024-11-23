//
//  Pannels+Typical.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 17.10.2024.
//

import SwiftUI

extension Panel {

    static func code(_ title: String = "Code", font: Font = Theme.Font.codeExtraSmall, @CodeBuilder _ lines: @escaping () -> [Code.Line]) -> Panel {
        Panel(title) {
            CodeView(code: Code(lines: lines), font: font)
        }
    }

    static func viewTree(_ title: String = "View Tree", content: @escaping () -> Tree) -> Panel {
        Panel(title) {
            TreeView(content())
        }
    }

    static func renderTree(_ title: String = "Render Tree", font: Font = Theme.Font.body, content: @escaping () -> Tree) -> Panel {
        Panel(title) {
            TreeView(content())
                .relation(.renderTree)
                .treeTitleStyle(TextStyle(font: font, color: Theme.Color.contentPrimary))
        }
    }

    static func bullets(
        _ title: String,
        style: BulletList.Style = .enumerated,
        @ArrayBuilder<String> _ items: @escaping () -> [String]
    ) -> Panel {
        Panel(title) {
            BulletList(style, items: items)
        }
    }

    static func preview<Content: View>(_ title: String = "Preview", @ViewBuilder _ content: @escaping () -> Content) -> Panel {
        Panel(title) {
            PreviewView {
                content()
            }
        }
    }
}
