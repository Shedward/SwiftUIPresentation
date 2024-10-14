//
//  With.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//

protocol Whithable {
}

extension Whithable {
    @inlinable
    func with(_ body: (inout Self) throws -> Void) rethrows -> Self {
        var changed = self
        try body(&changed)
        return changed
    }

    @inlinable
    func with<T>(_ keypath: WritableKeyPath<Self, T>, to newValue: T) -> Self {
        var changed = self
        changed[keyPath: keypath] = newValue
        return changed
    }
}
