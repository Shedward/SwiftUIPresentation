//
//  S15_ConditionalContent.swift
//  PresentationGraphics
//
//  Created by Vlad Maltsev on 20.10.2024.
//

import SwiftUI

struct S15_ConditionalContent: View, Slide {

    @Environment(\.episode)
    var episode: String

    var episodes: [Episode] {
        "e01-if-без-else"
        "e02-if-с-else"
        "e03-if-с-else-if"
        "e04-несколько-if"
        "e05-switch"
    }

    var notes: String? {
        """
        e00 - Другая вещь которую мы можем сделать в теле @ViewBuilder'а это написать if
        e01 - Точно так же if у нас будет представлен в дереве.
            - Для if'а без else это будет Optional
        e02 - Для if с else это будет _ConditionalContent
        e03 - Заменив на else if - получим Optional в _ConditionalContent
        e04 - Цепочки из if'ов превращаются в цепочки _ConditionalContent
        e05 - При использовании switch и guard и т.д. так же получаем цепочки _ConditionalContent
        """
    }

    var body: some View {
        TitleSubtitleLayout(title: "Ветвление") {
            Panels {
                Panel.code {
                    "struct OnlineStatus: View {"
                    "    let status: Status"
                    ""
                    "    var body: some View {"
                    if episode < "e05-switch" {
                        "        if status == .online {"
                            .highlight(("e01-if-без-else"..."e02-if-с-else").contains(episode))
                        "            Image(systemName: \"checkmark.circle.fill\")"
                        "            Text(\"Online\")"
                        switch episode {
                        case "e02-if-с-else":
                            "        } else {"
                            "            Text(\"Offline\")"
                            "        }"
                        case "e03-if-с-else-if":
                            "        } else if status == .offline {"
                            "            Text(\"Offline\")"
                            "        }"
                        case "e04-несколько-if":
                            "        } else if status == .offline {"
                            "            Text(\"Offline\")"
                            "        } else {"
                            "            Text(\"Unavailable\")"
                            "        }"
                        default:
                            "        }"
                        }
                        "     }"
                    } else {
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
                    }
                    "}"
                }

                Panel.viewTree {
                    if episode == "e01-if-без-else" {
                        Tree("VStack") {
                            Tree("Optional") {
                                Tree("TuppleView") {
                                    Tree("Image")
                                    Tree("Text")
                                }
                            }
                            .highlight()
                        }
                    } else if episode == "e02-if-с-else" {
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
                    } else if episode == "e03-if-с-else-if" {
                        Tree("VStack") {
                            Tree("_ConditionalContent", id: "outer-condition") {
                                Tree("TuppleView") {
                                    Tree("Image")
                                    Tree("Text", id: "online-text")
                                }
                                Tree("Optional", id: "inner-condition") {
                                    Tree("Text", id: "offline-text")
                                }
                            }
                        }
                    } else if episode == "e04-несколько-if" {
                        Tree("VStack") {
                            Tree("_ConditionalContent", id: "outer-condition") {
                                Tree("TuppleView") {
                                    Tree("Image")
                                    Tree("Text", id: "online-text")
                                }
                                Tree("_ConditionalContent", id: "inner-condition") {
                                    Tree("Text", id: "offline-text")
                                    Tree("Text", id: "unavailable-text")
                                }
                            }
                        }
                    } else if episode == "e05-switch" {
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
                    } else {
                        Tree("-")
                    }
                }.showIf(episode, after: "e01-if-без-else")
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
