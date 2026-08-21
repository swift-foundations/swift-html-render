import Render_Primitives
public import WHATWG_HTML_Shared

extension String: HTML.View {
    public var body: HTML.Text {
        HTML.Text(self)
    }
}
