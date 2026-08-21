import ASCII
public import Render_Primitives
public import WHATWG_HTML_Shared

extension HTML {

    public struct Text: HTML.View, Sendable {

        public let text: String

        public init(_ text: String) {
            self.text = text
        }
    }
}

extension HTML.Text {
    public typealias Body = Never
    public var body: Never { fatalError("Body is Never and must not be accessed.") }

    public static func _render(
        _ view: borrowing Self,
        context: inout Render.Context
    ) {
        context.text(view.text)
    }

    public static func + (lhs: Self, rhs: Self) -> Self {
        HTML.Text(lhs.text + rhs.text)
    }
}

extension HTML.Text: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value)
    }
}

extension HTML.Text: ExpressibleByStringInterpolation {}
