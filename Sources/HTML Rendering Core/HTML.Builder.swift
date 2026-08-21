public import Render_Primitives
public import WHATWG_HTML_Shared

extension Render.Builder {

    public static func buildBlock() -> Render.Empty {
        Render.Empty()
    }
}

extension HTML {
    public typealias Builder = Render.Builder
}
