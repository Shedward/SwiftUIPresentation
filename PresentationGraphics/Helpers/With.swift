//
//  With.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 13.10.2024.
//

protocol Whithable {
    @inlinable
    func with(_ body: (inout Self) throws -> Void) rethrows -> Self
}

extension Whithable {
    @inlinable
    func with(_ body: (inout Self) throws -> Void) rethrows -> Self {
        var changed = self
        try body(&changed)
        return changed
    }
}
