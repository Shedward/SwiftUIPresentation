//
//  Episode+Shortcuts.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 02.11.2024.
//

func lines(_ lines: () -> [String]) -> String {
    lines()
        .map { "- \($0)" }
        .joined(separator: "\n")
}

let e00 = Episode("e00")
func e00(_ notes: String) -> Episode {
    Episode("e00", notes: notes)
}
func e00(@ArrayBuilder<String> notes: () -> [String]) -> Episode {
    Episode("e00", notes: lines(notes))
}

let e01 = Episode("e01")
func e01(_ notes: String) -> Episode {
    Episode("e01", notes: notes)
}
func e01(@ArrayBuilder<String> notes: () -> [String]) -> Episode {
    Episode("e01", notes: lines(notes))
}

let e02 = Episode("e02")
func e02(_ notes: String) -> Episode {
    Episode("e02", notes: notes)
}
func e02(@ArrayBuilder<String> notes: () -> [String]) -> Episode {
    Episode("e02", notes: lines(notes))
}

let e03 = Episode("e03")
func e03(_ notes: String) -> Episode {
    Episode("e03", notes: notes)
}
func e03(@ArrayBuilder<String> notes: () -> [String]) -> Episode {
    Episode("e03", notes: lines(notes))
}

let e04 = Episode("e04")
func e04(_ notes: String) -> Episode {
    Episode("e04", notes: notes)
}
func e04(@ArrayBuilder<String> notes: () -> [String]) -> Episode {
    Episode("e04", notes: lines(notes))
}

let e05 = Episode("e05")
func e05(_ notes: String) -> Episode {
    Episode("e05", notes: notes)
}
func e05(@ArrayBuilder<String> notes: () -> [String]) -> Episode {
    Episode("e05", notes: lines(notes))
}

let e06 = Episode("e06")
func e06(_ notes: String) -> Episode {
    Episode("e06", notes: notes)
}
func e06(@ArrayBuilder<String> notes: () -> [String]) -> Episode {
    Episode("e06", notes: lines(notes))
}

let e07 = Episode("e07")
func e07(_ notes: String) -> Episode {
    Episode("e07", notes: notes)
}
func e07(@ArrayBuilder<String> notes: () -> [String]) -> Episode {
    Episode("e07", notes: lines(notes))
}

let e08 = Episode("e08")
func e08(_ notes: String) -> Episode {
    Episode("e08", notes: notes)
}
func e08(@ArrayBuilder<String> notes: () -> [String]) -> Episode {
    Episode("e08", notes: lines(notes))
}

let e09 = Episode("e09")
func e09(_ notes: String) -> Episode {
    Episode("e09", notes: notes)
}
func e09(@ArrayBuilder<String> notes: () -> [String]) -> Episode {
    Episode("e09", notes: lines(notes))
}
