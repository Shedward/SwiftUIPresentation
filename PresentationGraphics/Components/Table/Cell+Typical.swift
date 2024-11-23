//
//  Cell+Typical.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 25.10.2024.
//

import Foundation

extension Table.Cell {
    static func code(id: String = UUID().uuidString, @CodeBuilder code: () -> Code) -> Self {
        Table.Cell(id: id) {
            CodeView(code: code(), font: Theme.Font.codeExtraSmall)
                .framed(fill: Theme.Color.backgroundSecondary)
                .gridColumnAlignment(.leading)
        }
    }
}
