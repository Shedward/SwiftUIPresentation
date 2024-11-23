//
//  PreferencesExample.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 23.11.2024.
//

import SwiftUI

struct MixingBackgroundColorKey: PreferenceKey {
    static let defaultValue: Color? = nil

    static func reduce(value: inout Color?, nextValue: () -> Color?) {
        value = value.mix(nextValue())
    }
}

extension Optional where Wrapped == Color {
    func mix(_ other: Color?) -> Color? {
        switch (self, other) {
        case (.some(let lhs), .some(let rhs)):
            lhs.mix(with: rhs, by: 0.5)
        case (.some(let lhs), .none):
            lhs
        case (.none, .some(let rhs)):
            rhs
        case (.none, .none):
            nil
        }
    }
}



extension View {
    func mixingBackground(_ color: Color?) -> some View {
        self
            .background(color ?? .clear)
            .preference(key: MixingBackgroundColorKey.self, value: color)
    }
}

struct MixedBackgroundModifier: ViewModifier {

    @State
    private var mixedColor: Color = .clear

    func body(content: Content) -> some View {
        content
            .onPreferenceChange(MixingBackgroundColorKey.self) { mixedColor in
                print("Preference changed: \(mixedColor ?? .clear)")
                self.mixedColor = mixedColor ?? .clear
            }
            .background(mixedColor.opacity(0.5))
    }
}

extension View {
    func mixedBackground() -> some View {
        padding(8)
            .modifier(MixedBackgroundModifier())
    }
}

struct CollectsIdsKey: PreferenceKey {
    static let defaultValue: [String] = ["none"]

    static func reduce(value: inout [String], nextValue: () -> [String]) {
        value += nextValue()
    }
}

struct CollectsIdsTestView: View {

    @State
    var ids: [String] = []

    var body: some View {
        HStack {
            Text("ids: \(ids.joined(separator: ", "))")
            VStack {
                Box(100)
                    .background(.white)
                    .preference(key: CollectsIdsKey.self, value: ["white"])
                Box(100)
                    .background(.red)
            }
            Box(100)
                .background(.blue)
                .preference(key: CollectsIdsKey.self, value: ["blue"])
        }
        .onPreferenceChange(CollectsIdsKey.self) { ids in
            self.ids = ids
        }
    }
}

#Preview {
    HStack {
        VStack {
            Box(100)
                .background(.white)
            Box(100)
                .background(.red)
        }
        .mixedBackground()
        Box(100)
            .background(.blue)
    }
    .mixedBackground()
    .padding()
}


#Preview {
    CollectsIdsTestView()
}
