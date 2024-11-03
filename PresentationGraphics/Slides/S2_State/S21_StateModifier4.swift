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
        e00(
            """
            - Но если все таки нам нужно рисовать вьюху и от внешнего и от внутреннего стейта?
            - Самый классический пример - это реализация подсветок, они зависят от стилей снаружи, и от состояния нажатия внутри
            """
        )

        e01(
            """
            - Во первых - в любом случае нам придется разделить стейт на внешний и внутренний
            - И дальше у нас есть как минимум два стула
            """
        )

        e02(
            """
            - Более чистый - вычислять финальное состояние как функцию от внешнего и внутреннего
            - Тогда для любой комбинации внешнего и внутреннего мы получим валидное состояние
            - Но бывают кейсы когда состояние слишком тяжелое чтобы каждый раз его считать
            - Либо переходы между состояниями ассимитричные и зависят от прошлого состояния
            """
        )

        e03(
            """
            - Тогда мы можем реагировать на внешние изменения через onAppear/onChange
            - Но, за это придется заплатить
            - Во первых у вас всегда будет вторая перерисовка (и это плохо влияет на лайаут и анимации)
            - Во вторых состояние становится недетерминированым. Порядок применения изменений извне может повлиять на результат
            
            - К счастью @State мы используем довольно редко, т.к. в 9/10 случаев состояние у нас идет из вью модели
            - Но @State необходим при работе с анимациями и UI реакциями на действия пользователя
            """
        )
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
