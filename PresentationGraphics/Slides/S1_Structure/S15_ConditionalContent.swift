//
//  S15_ConditionalContent.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 20.10.2024.
//

import SwiftUI

struct S15_ConditionalContent: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00 {
            "Еще мы можем в теле @ViewBuilder'а использовать if"
        }
        e01 {
            "В дереве if представлен Optional'ом"
        }
        e02 {
            "Добавим else ветку"
            "В дереве Optional у нас превратиться в _ConditionalContent"
        }
        e03 {
            "Заменим else на else if"
            "В дереве появляется Optional"
        }
        e04 {
            "Т.е. цепочки if превращаются в цепочки _ConditionalContent и Optional"
        }
        e05 {
            "Еще мы можем использовать switch"
            "Он тоже превращается в цепочку _ConditionalContent"
        }
        e06 {
            "Еще мы можем использовать if let"
            "Он в дереве превращается в Optional"
        }
        e07 {
            "И еще мы можем использовать Optional напрямую"
            "В дереве это будет очевидно Optional"
        }
    }

    var body: some View {
        TitleSubtitleLayout(title: "Ветвление") {
            Panels {
                Panel.code {
                    "struct OnlineStatus: View {"
                    "    let status: Status"
                    " "
                    "    var body: some View {"
                    if episode < e05 {
                        "        if status == .online {"
                            .highlight((e01...e02).contains(episode))
                        "            Image(systemName: \"checkmark.circle.fill\")"
                        "            Text(\"Online\")"
                        switch episode {
                        case e02:
                            "        } else {"
                            "            Text(\"Offline\")"
                            "        }"
                        case e03:
                            "        } else if status == .offline {".highlight()
                            "            Text(\"Offline\")"
                            "        }"
                        case e04:
                            "        } else if status == .offline {"
                            "            Text(\"Offline\")"
                            "        } else {".highlight()
                            "            Text(\"Unavailable\")"
                            "        }"
                        default:
                            "        }"
                        }
                    } else if episode == e05 {
                        """
                                switch status {
                                    case .online:
                                        Image(systemName: "checkmark.circle.fill")
                                        Text("Online")
                                    case .offline:
                                        Text("Offline")
                                    case .unavailable:
                                        Text("Unavailable")
                                    case .banned
                                        Text("Banned")
                                }
                        """
                    } else if episode == e06 {
                        """
                                if let description = status.description {
                                    Image(systemName: "checkmark.circle.fill")
                                    Text(description)
                                }
                        """
                    } else if episode == e07 {
                        """
                                Image(systemName: "checkmark.circle.fill")
                                status.description.map { Text($0) }
                        """
                    }
                    "    }"
                    "}"
                }

                Panel.viewTree {
                    if episode == e01 {
                        Tree("VStack") {
                            Tree("Optional") {
                                Tree("TuppleView") {
                                    Tree("Image")
                                    Tree("Text")
                                }
                            }
                            .highlight()
                        }
                    } else if episode == e02 {
                        Tree("VStack") {
                            Tree("_ConditionalContent") {
                                Tree("TuppleView") {
                                    Tree("Image")
                                    Tree("Text", id: "online-text")
                                }
                                Tree("Text", id: "offline-text")
                            }
                            .highlight()
                        }
                    } else if episode == e03 {
                        Tree("VStack") {
                            Tree("_ConditionalContent", id: "outer-condition") {
                                Tree("TuppleView") {
                                    Tree("Image")
                                    Tree("Text", id: "online-text")
                                }
                                Tree("Optional", id: "inner-condition") {
                                    Tree("Text", id: "offline-text")
                                }.highlight()
                            }
                        }
                    } else if episode == e04 {
                        Tree("VStack") {
                            Tree("_ConditionalContent", id: "outer-condition") {
                                Tree("TuppleView") {
                                    Tree("Image")
                                    Tree("Text", id: "online-text")
                                }
                                Tree("_ConditionalContent", id: "inner-condition") {
                                    Tree("Text", id: "offline-text")
                                    Tree("Text", id: "unavailable-text")
                                }.highlight()
                            }
                        }
                    } else if episode == e05 {
                        Tree("VStack") {
                            Tree("_ConditionalContent", id: "outer-condition") {
                                Tree("TuppleView") {
                                    Tree("Image")
                                    Tree("Text", id: "online-text")
                                }
                                Tree("_ConditionalContent", id: "inner-condition") {
                                    Tree("Text", id: "offline-text")
                                    Tree("_ConditionalContent", id: "inner-inner-condition") {
                                        Tree("Text", id: "unavailable-text")
                                        Tree("Text", id: "banned-text")
                                    }
                                }
                            }
                        }
                    } else if episode == e06 {
                        Tree("VStack") {
                            Tree("Optional") {
                                Tree("TuppleView") {
                                    Tree("Image")
                                    Tree("Text")
                                }
                            }.highlight()
                        }
                    } else if episode == e07 {
                        Tree("VStack") {
                            Tree("TuppleView") {
                                Tree("Image")
                                Tree("Optional") {
                                    Tree("Text")
                                }.highlight()
                            }
                        }
                    } else {
                        Tree("-")
                    }
                }.showIf(episode, after: e01)
            }
        }
    }
}

private struct OnlineStatus: View {
    let isOnline: Bool

    var body: some View {
        if isOnline {
            Image(systemName: "checkmark.circle.fill")
            Text("Online")
        }
    }
}
