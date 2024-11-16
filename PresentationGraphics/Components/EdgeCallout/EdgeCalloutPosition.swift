//
//  EdgeCalloutPosition.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 13.11.2024.
//

import SwiftUI

enum EdgeCalloutPositionLayoutKey: LayoutValueKey {
    static var defaultValue = UnitPoint(x: 0.75, y: 1.0)
}

extension View {
    func edgeCalloutPosition(_ point: UnitPoint) -> some View {
        layoutValue(key: EdgeCalloutPositionLayoutKey.self, value: point)
    }
}
