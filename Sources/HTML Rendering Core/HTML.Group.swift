public import Render_Primitives
public import WHATWG_HTML_Shared

extension HTML {
    public typealias Group = Render.Group
}

extension Render.Group: HTML.View where Content: HTML.View {}
