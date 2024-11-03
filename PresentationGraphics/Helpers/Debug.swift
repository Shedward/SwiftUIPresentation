//
//  LIfecyclePrint.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 03.11.2024.
//

import SwiftUI

extension View {

    func debugLifecycle(file: StaticString = #fileID, line: UInt = #line) -> some View {
        let lineId = LineId(file: file, line: line)
        return self.onAppear { print("- onAppear \(lineId)") }
            .onDisappear { print("- onDisappear \(lineId)") }
    }

    func debugOnChange<T: Equatable>(
        _ value: T,
        file: StaticString = #fileID,
        line: UInt = #line
    ) -> some View {
        onChange(of: value) { oldValue, newValue in
            print("- onChange \(LineId(file: file, line: line)): \(oldValue) -> \(newValue)")
        }
    }
}
