import Render_Primitives
public import Ownership_Mutable_Primitives
public import WHATWG_HTML_Shared

extension Render.Context {
    /// Creates a rendering context that forwards all operations to an HTML context.
    ///
    /// The HTML context is captured via `Ownership.Mutable` so that closures
    /// share mutable access to the same underlying state.
    ///
    /// - Parameter state: A mutable reference to the HTML rendering state.
    /// - Returns: A witness-based rendering context backed by the HTML context.
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
                element: { HTML.Context._pushElement(&state.value, tagName: $0, isBlock: $1, isVoid: $2, isPreElement: $3) },
                // A style scope isolates the class attribute it accumulates so an
                // element's generated classes don't leak to the next sibling. That's
                // exactly the attribute save/restore, so reuse it (the default
                // `style` witness is a no-op, which let classes leak forward).
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
