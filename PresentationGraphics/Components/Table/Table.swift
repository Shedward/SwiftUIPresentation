//
//  Table.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 20.10.2024.
//

import SwiftUI

struct Table: View {

    @Environment(\.space)
    var space: Space

    let header: Header
    let alignment: Alignment
    let rows: [Row]

    public init(
        header: Header = .init(),
        alignment: Alignment = .center,
        @ArrayBuilder<Row> rows: () -> [Row]
    ) {
        self.header = header
        self.alignment = alignment
        self.rows = rows()
    }
    
    public var body: some View {
        Grid(
            alignment: alignment,
            horizontalSpacing: space.innerValue(),
            verticalSpacing: space.innerValue()
        ) {
            GridRow(alignment: .center) {
                ForEach(header.titles, id: \.self) { title in
                    Text(title)
                        .style(.caption)
                }
            }

            ForEach(rows, id: \.id) { row in
                Divider()
                    .gridCellUnsizedAxes([.horizontal, .vertical])
                GridRow {
                    ForEach(row.cells, id: \.id) { cell in
                        cell.content
                    }
                }
            }
        }
        .reduceSpacing()
    }
}

extension Table {
    struct Header {
        let titles: [String]

        init(_ titles: String...) {
            self.titles = titles
        }
    }

    struct Row: Identifiable {
        let id: String
        let cells: [Cell]

        init(id: String = UUID().uuidString, @ArrayBuilder<Cell> content: () -> [Cell]) {
            self.id = id
            self.cells = content()
        }
    }

    struct Cell: Identifiable {
        let id: String
        let content: AnyView

        init<Content: View>(id: String = UUID().uuidString, @ViewBuilder _ content: () -> Content) {
            self.id = id
            self.content = AnyView(content())
        }
    }
}
