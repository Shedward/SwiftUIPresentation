//
//  S17_ViewBuilderIsNotACode.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 20.10.2024.
//

import SwiftUI

struct S19_Lifecycle: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00 {
            "И в целом эти 3 действия составляют жизненный цикл любой вьюхи"
            "Жизненный цикл тут определяется жизнью RenderTree"
            "При попадании в дерево - вьюха создается"
            "При изменениях она может обновиться множество раз"
            "И после удаления из дерева - вьюха исчезает"

            "При этом ViewTree сохраняется постоянным"
            "И создаваться и уничтожаться может много много раз"
            "Время жизни ViewTree эфимерно"
        }

        e01 {
            "И чтобы немного приземлить идеи ViewTree и RenderTree - где мы можем их увидеть?"
            "ViewTree - это структура нашего кода, это тело body. Оно статично и не меняется"
            "ViewTree - это чертеж нашей вьюхи"

            "RenderTree - это то что мы видим на экране и AttributeGraph под капотом"
            "RenderTree зависит от состояния и меняется каждый раз, когда мы меняем состояние"
        }
    }

    var body: some View {
        TitleSubtitleLayout(title: "Жизненный цикл") {
            Panels {
                Panel.code("View Tree - код") {
                    """
                    struct SomeView: View {
                        let isOnline: Bool
                    
                        var body: some View {
                            HStack {
                                Image("statusIcon")
                                if isOnline {
                                    Text("Online")
                                } else {
                                    Text("Offline")
                                }
                            }
                        }
                    }
                    """
                }.showIf(episode, at: e01)

                Panel("View Tree") {
                    LifecycleView {
                        ForEach(0..<5) { _ in
                            LifecycleLine.instance {
                                Text("body")
                                    .style(.body)
                            }
                        }
                    }
                }

                Panel("Render Tree") {
                    LifecycleView {
                        LifecycleLine.appear {
                            Text("onAppear")
                                .style(.body)
                        }

                        LifecycleLine.change {
                            Text("onChange(value1)")
                                .style(.body)
                        }

                        LifecycleLine.change {
                            Text("onChange(value2)")
                                .style(.body)
                        }

                        LifecycleLine.change {
                            Text("onChange(value1)")
                                .style(.body)
                        }

                        LifecycleLine.disappear {
                            Text("onDisappear")
                                .style(.body)
                        }
                    }
                }

                Panel.renderTree("Render Tree - на экране") {
                    Tree("HStack") {
                        Tree("Image")
                        Tree("_ConditionalView") {
                            Tree("Text")
                                .caption("Online")
                        }
                        .caption("true")
                    }
                }
                .showIf(episode, at: e01)
            }
        }
    }
}
