public import Ownership_Mutable_Primitives
import Render_Primitives
public import WHATWG_HTML_Shared

extension Render.Context {

    public static func html(state: Ownership.Mutable<HTML.Context>) -> Self {
        .init(
            text: { state.value.text($0) },
            break: Render.Break(
                line: { state.value.lineBreak() },
                thematic: { state.value.thematicBreak() },
                page: { state.value.pageBreak() }
            ),
            image: { state.value.image(source: $0, alt: $1) },
            push: Render.Push(
                block: { HTML.Context._pushBlock(&state.value, role: $0, style: $1) },
                inline: { HTML.Context._pushInline(&state.value, role: $0, style: $1) },
                list: { HTML.Context._pushList(&state.value, kind: $0, start: $1) },
                item: { HTML.Context._pushItem(&state.value) },
                link: { HTML.Context._pushLink(&state.value, destination: $0) },
                attributes: { HTML.Context._pushAttributes(&state.value) },
                element: {
                    HTML.Context._pushElement(
                        &state.value,
                        tagName: $0,
                        isBlock: $1,
                        isVoid: $2,
                        isPreElement: $3
                    )
                },

                style: { HTML.Context._pushAttributes(&state.value) }
            ),
            pop: Render.Pop(
                block: { HTML.Context._popBlock(&state.value) },
                inline: { HTML.Context._popInline(&state.value) },
                list: { HTML.Context._popList(&state.value) },
                item: { HTML.Context._popItem(&state.value) },
                link: { HTML.Context._popLink(&state.value) },
                attributes: { HTML.Context._popAttributes(&state.value) },
                element: { HTML.Context._popElement(&state.value, isBlock: $0) },
                style: { HTML.Context._popAttributes(&state.value) }
            ),
            setAttribute: { state.value.set(attribute: $0, $1) },
            addClass: { state.value.add(class: $0) },
            writeRaw: { state.value.write(raw: $0) },
            registerStyle: { state.value.register(style: $0, atRule: $1, selector: $2, pseudo: $3) }
        )
    }
}
