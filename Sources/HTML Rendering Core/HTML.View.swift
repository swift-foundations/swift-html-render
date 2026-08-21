import Dictionary_Ordered_Primitives
public import Render_Primitives
public import WHATWG_HTML_Shared

extension HTML {
    public protocol View: Render.View where Body: HTML.View {
        @HTML.Builder var body: Body { get }
    }
}

extension HTML.View {

    public func attribute(_ name: String, _ value: String? = "") -> HTML._Attributes<Self> {
        var attributes = HTML.Context.Attributes()
        if let value {
            attributes[name] = value
        }
        return HTML._Attributes(content: self, attributes: attributes)
    }
}

extension CustomStringConvertible where Self: HTML.View {
    public var description: String {
        do throws(HTML.Context.Configuration.Error) {
            return try String(self)
        } catch {
            return ""
        }
    }
}
