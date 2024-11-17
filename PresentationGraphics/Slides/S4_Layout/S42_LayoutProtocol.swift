//
//  S30_Animations.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 08.11.2024.
//

import SwiftUI

struct S42_LayoutProtocol: View, Slide {

    @Environment(\.episode)
    var episode: Episode

    var episodes: [Episode] {
        e00(
            """
            - С iOS 16 мы можем влезть в этот процесс напрямую если реализуем протокол Layout
            - Минимальная реализация его выглядит вот так
            - Мы обязаны заимплементить два метода 
            - sizeThatFits который высчитывает размер
            - placeSubviews который раскидывает вьюхи
            """
        )

        e01(
            """
            - Идейно Layout это просто вьюха
            - Абсолютно похожая по использованию на наши HStack/VStack и т.д.
            """
        )

        e02(
            """
            - Деревом это будет выглядеть так
            - Самому лайауту не известно какие конкретно вьюхи в нем лежат
            - Он работает с ними через прокси-коллекцию Subviews
            - А предложения размеров передаются через ProposedViewSize
            - Давайте чтобы прочуствовать сделаем самый примитивный VStack
            """
        )

        e03(
            """
            - Сначала нам нужно посчитать размер 
            - Выглядеть это может примерно вот так
            """
        )

        Episode("e03-01", notes: "- Контейнер спрашивает нас наш размер, предлагая свой ProposedViewSize")
        Episode(
            "e03-02",
            notes: """
            - Затем мы в нашем лайауте спрашиваем размер у каждой сабвьюхи
            - Спрашиваем мы это используя структуру ProposedViewSize из двух опциональных width и height
                - В ней мы можем передать конкретное значение
                - .infitine если хотим узнать прям максимальное значение 
                - 0 если хотим узнать минимальное
                - Или nil - если хотим "идеальное" на усмотрение самой вьюхи
                - Более того - мы тут можем спрашивать вьюху множество раз предлагая разные варианты
                - Ища тот который нас удовлетворит
                - Или например спросить максимальный и минимальный размер чтобы получить тянучесть вьюхи
            - Допустим тут мы предлагаем им занять всю доступную ширину, но высоту можно выбрать любую
            """
        )
        Episode(
            "e03-03",
            notes: """
            - Каждая сабвьюха отвечает нам своим размером под предложенный пропоузал
            """
        )

        Episode(
            "e03-04",
            notes: """
            - Мы складываем высоты, находим максимальную ширину и в итоге получаем размеры нашего лайаута
            - Лайаут сообщает свой размер контейнеру
            - И с расчетом размеров теперь закончили
            """
        )

        e04(
            """
            - Теперь давайте положим вьюхи на их законные места
            - Для этого нам нужно реализовать placeSubviews
            """
        )

        Episode(
            "e04-01",
            notes: """
            - Тут нам приходит bounds рассчитаный по размеру который мы отдали
            - И пропоузал под который она была рассчитана
            """
        )

        Episode(
            "e04-02",
            notes: """
            - Сначала нам нужно найти точку к которой мы будем крепить наши вьюхи
            - У нас это будет по центру сверху внутри заданных bounds
            """
        )

        Episode(
            "e04-03",
            notes: """
            - Затем располагаем вьюху
            - Обратите внимание что мы указываем не frame как раньше
            - А положение и anchor.
            - Т.е. теперь у нас безразмерная юнит-геометрия вместо абсолютных фреймов
            - Размер определяет сама вьюха
            - Заставить чайлда принять другой размер мы просто не можем
            """
        )

        Episode(
            "e04-04",
            notes: """
            - Добавляем размер размещенной вьюхи к опорной точке
            """
        )

        Episode(
            "e04-05",
            notes: """
            - И проходимся по оставшимся
            """
        )

        Episode(
            "e04-06",
            notes: """
            - Чайлд под капотом может вызвать другой лайаут, и процесс повторится для всех подвьюх
            """
        )

        e05(
            """
            - И в итоге чайлды отрисовывают себя на экране в указаных точках
            """
        )
    }

    var body: some View {
        TitleSubtitleLayout(title: "Layout", subtitle: "Протокол") {
            Panels {
                Panel.code("Layout") {
                    """
                    struct CustomLayout: Layout {
                        func sizeThatFits(
                            proposal: ProposedViewSize,
                            subviews: Subviews,
                            cache: inout ()
                        ) -> CGSize {
                            ...
                        }
                         
                        func placeSubviews(
                            in bounds: CGRect,
                            proposal: ProposedViewSize,
                            subviews: Subviews,
                            cache: inout ()
                        ) {
                            ...
                        }
                    }
                    """
                }.hideIf(episode, after: e03)

                Panel.code("Размер") {

                    "func sizeThatFits("
                    "    proposal: ProposedViewSize,"
                        .highlight(episode == Episode("e03-01"))
                    "    subviews: Subviews,"
                    "    cache: inout ()"
                    ") -> CGSize {"
                    "    let sizes = subviews.map { subview in"
                        .highlight(episode == Episode("e03-03"))
                    "        subview.sizeThatFits("
                    "            ProposedViewSize(width: proposal.width, height: nil)"
                        .highlight(episode == Episode("e03-02"))
                    "        )"
                    "    }"
                    " "
                    "    return CGSize("
                    "        width: sizes.map(\\.width).max() ?? 0,"
                        .highlight(episode == Episode("e03-04"))
                    "        height: sizes.map(\\.height).reduce(0, +)"
                        .highlight(episode == Episode("e03-04"))
                    "    )"
                    "}"
                }
                .showIf(episode, in: e03...Episode("e03-99"))

                Panel.code("Расположение") {
                    "public func placeSubviews("
                    "    in bounds: CGRect,"
                        .highlight(episode == Episode("e04-01"))
                    "    proposal: ProposedViewSize,"
                        .highlight(episode == Episode("e04-01"))
                    "    subviews: Subviews,"
                    "    cache: inout ()"
                    ") {"
                    "    var position = bounds.unitPoint(.top)"
                        .highlight(episode == Episode("e04-02"))
                    "    let proposal = ProposedViewSize(width: proposal.width, height: nil)"
                    " "
                    "    subviews.forEach { subview in"
                    "        subview.place("
                    "            at: position,"
                        .highlight(episode == Episode("e04-03"))
                    "            anchor: UnitPoint(x: 0.5, y: 0),"
                        .highlight(episode == Episode("e04-03"))
                    "            proposal: proposal"
                        .highlight(episode == Episode("e04-03"))
                    "        )"
                    "        let subviewSize = subview.sizeThatFits(proposal)"
                        .highlight(episode == Episode("e04-05"))
                    "        position.y += subviewSize.height"
                        .highlight(episode == Episode("e04-05"))
                    "    }"
                    "}"
                }
                .showIf(episode, in: e04...e05)

                Panel.code("Использование") {
                    """
                    var body: some View {
                        CustomContainer {
                            Image("image")
                            Text("Some Text")
                            Circle()
                        }
                    }
                    """
                }
                .showIf(episode, at: e01)

                Panel.renderTree {
                    Tree("Container") {
                        Tree("CustomLayout") {
                            Tree("Subview", id: "subview1")
                                .body {
                                    Image(systemName: "photo.artframe")
                                        .font(.system(size: 25))
                                        .frame(width: 50, height: 50)
                                        .tint(Color.blue)
                                        .bordered()
                                        .annotatable("image")
                                }
                            Tree("Subview", id: "subview2")
                                .body {
                                    Text("Some Text")
                                        .padding()
                                        .bordered()
                                        .annotatable("text")
                                }
                            Tree("Subview", id: "subview3")
                                .body {
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: 25, height: 25)
                                        .padding()
                                        .bordered()
                                        .annotatable("circle")
                                }
                        }.annotatable("layout")
                    }.annotatable("container")
                }
                .annotate{
                    TextAnnotation(to: "container", message: "(100, 800)?")
                        .parentProposeKind()
                        .showIf(episode, in: Episode("e03-01")...Episode("e03-99"))

                    TextAnnotation(to: "layout", message: "(100, nil)?")
                        .parentProposeKind()
                        .showIf(episode, in: Episode("e03-02")...Episode("e03-99"))

                    showIf(episode, in: Episode("e03-03")...Episode("e03-99")) {
                        TextAnnotation(to: "image", message: "(50, 50)!")
                            .childResponseKind()
                            .position(.bottom)

                        TextAnnotation(to: "text", message: "(100, 18)!")
                            .childResponseKind()
                            .position(.bottom)

                        TextAnnotation(to: "circle", message: "(25, 25)!")
                            .childResponseKind()
                            .position(.bottom)
                    }
                    TextAnnotation(to: "layout", message: "(100, 93)!")
                        .childResponseKind()
                        .showIf(episode, at: Episode("e03-04"))

                    TextAnnotation(to: "container", message: "bounds: (7, 10, 100, 93)\npropose: (100, 800)?")
                        .parentProposeKind()
                        .showIf(episode, in: Episode("e04-01")...Episode("e04-99"))

                    TextAnnotation(to: "image", message: "position: (47, 10)\nanchor: (0.5, 0)\nproposal: (100, nil)")
                        .parentProposeKind()
                        .position(.bottomLeading)
                        .showIf(episode, in: Episode("e04-03")...Episode("e04-99"))
                    TextAnnotation(to: "text", message: "position: (47, 60)\nanchor: (0.5, 0)\nproposal: (100, nil)")
                        .parentProposeKind()
                        .position(.bottom)
                        .showIf(episode, in: Episode("e04-05")...Episode("e04-99"))
                    TextAnnotation(to: "circle", message: "position: (47, 78)\nanchor: (0.5, 0)\nproposal: (100, nil)")
                        .parentProposeKind()
                        .position(.bottomTrailing)
                        .showIf(episode, in: Episode("e04-05")...Episode("e04-99"))
                    TextAnnotation(to: "text", message: "\n\n\n\n           ↓\nbounds: (7, 60, 100, 18)\nproposal: (100, nil)")
                        .parentProposeKind()
                        .position(.bottom)
                        .showIf(episode, in: Episode("e04-06")...Episode("e04-99"))
                }
                .showIf(episode, after: e02)


                Panel.preview {
                    CustomVerticalLayout {
                        Image(systemName: "photo.artframe")
                            .font(.system(size: 25))
                            .frame(width: 50, height: 50)
                            .tint(Color.blue)

                        Text("Some Text")
                            .padding()

                        Circle()
                            .fill(Color.red)
                            .frame(width: 25, height: 25)
                            .padding()
                    }
                }.showIf(episode, at: e05)
            }
        }
    }
}
