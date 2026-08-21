import Render_Primitives
public import WHATWG_HTML_Shared

extension HTML {

    public struct Doctype: HTML.View {

        public init() {}
    }
}

extension HTML.Doctype {

    public var body: some HTML.View {
        HTML.Raw([UInt8].html.tag.doctype)
    }
}
