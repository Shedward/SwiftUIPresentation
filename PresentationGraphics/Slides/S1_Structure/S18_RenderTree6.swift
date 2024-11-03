//
//  S17_ViewBuilderIsNotACode.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 20.10.2024.
//

import SwiftUI

struct S18_RenderTree6: View, Slide {

    var episodes: [Episode] {
        e00(
            """
            - И в целом эти 3 действия составляют жизненный цикл любой вьюхи
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "Render Tree", subtitle: "Жизненный цикл") {
            Panels {
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
            }
        }
    }
}
