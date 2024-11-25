//
//  S21_StateModifier4.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 02.11.2024.
//

import SwiftUI

struct S21_StateModifier4: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00 {
            "Если все таки нужно как то дружить внешнее и внетренее"
            "Например для подсветок которые зависят от стиля извне и от состояния нажатия"
        }

        e01 {
            "Во первых - в любом случае разделяем стейт на внешний и внутренний"
            "И дальше есть как минимум 2 варианта"
        }

        e02 {
            "Более чистый - вычислить финальное состояние как функцию от внешнего и внутреннего"
            "Для любой комбинации получим валидное состояние"
            "Но бывает что состояние слишком тяжелое чтобы его пересчитывать"
            "Либо новое состояние зависит от прошлого"
        }

        e03 {
            "Тогда мы можем хранить состояние как @State, а на внешние изменения реагировать через onAppear/onChange"
            "Но за это придется заплатить"
            "Во первых появится вторая перерисовка, т.к. state меняется по onChange"
            "Во вторых - состояние недетерминированое. Порядок применения изменений может влиять на результат"
        }
    }

    var body: some View {
        TitleSubtitleLayout(
            title: "@State",
            subtitle: "Если все таки нужно"
        ) {
            Panels {
                Panel.code {
                    """
                    struct Button: View {
                        
                        @State
                        var appearance: Appearance
                         
                        init(style: Style) {
                            self.appearance = ???
                        }
                         
                        var body: some View {
                            content(appearance)
                                .onPress {
                                    appearance = ???
                                }
                        }
                    }
                    """
                }.hideIf(episode, after: e01)

                Panel.code("Разделяем внутренее и внешнее") {
                    """
                    struct Button: View {
                         
                        @State
                        var isPressed: Bool
                         
                        let style: Style
                         
                        init(style: Style) {
                            self.style = style
                        }
                        
                        var body: some View {
                            content(???)
                                .onPress { 
                                    isPressed = $0
                                }
                        }
                    }
                    """
                }
                .showIf(episode, after: e01)

                Panel.code("Чистое состояние") {
                    """
                    struct Button: View {
                        
                        @State
                        var isPressed: Bool
                        
                        let style: Style
                        
                        init(style: Style) {
                            self.style = style
                        }
                        
                        var body: some View {
                            content(appearance())
                                .onPress { 
                                    isPressed = $0
                                }
                        }
                        
                        func appearance() -> Appearance {
                            Appearance(style: style, isPressed: isPressed)
                        }
                    }
                    """
                }
                .showIf(episode, at: e02)

                Panel.code("Изменяемая модель") {
                    """
                    struct Button: View {
                        
                        @State
                        var appearance: Appearance = .initial
                        
                        let style: Style
                        
                        init(style: Style) {
                            self.style = style
                        }
                        
                        var body: some View {
                            content(appearance())
                                .onPress { 
                                    appearance.updateHighlight($0)
                                }
                                .onAppear {
                                    appearance.updateStyle(style)
                                }
                                .onChange(of: style) { style in
                                    appearance.updateStyle(style)
                                }
                        }
                    }
                    """
                }
                .showIf(episode, at: e03)
            }
        }
    }
}
