//
//  S23_Observable.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 03.11.2024.
//

import SwiftUI

struct S23_Observable3: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - Ну и не забываем что Observation не прибит гвоздями к SwiftUI
            - Его можно использовать и отдельно от UI
            - Например если вдруг захотим какой то сервис сделать Observable
            - И другому нужно подписаться на его изменения
            - То подписка почти всегда будет выглядеть примерно так
            - onChange сдесь создает отдельную таску из-за того
            - что onChange вызывается по факту на willChange, т.е. ДО изменения полей
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "@Observable", subtitle: "Не в UI") {
            Panels {
                Panel.code("Model") {
                    """
                    @Observable
                    final class Model {
                        var title = "Title"
                        var subtitle = "Subtitle"
                        var isOnline: Bool
                    """
                }

                Panel.code("Observant") {
                    """
                    final class ModelObservant {
                        let model: Model
                        var reportHeader: String?
                    
                        init(model: Model) {
                            self.model = model
                            updateReportHeader()
                        }
                    
                        private func updateReportHeader() {
                            withObservationTracking {
                                reportHeader = \"""
                                    \\(model.title)
                                    \\(model.subtitle
                                    ---
                                    \"""
                            } onChange: { [weak self] in
                                Task { self?.updateReportHeader() }
                            }
                        }
                    }
                    """
                }
            }
        }
    }
}
