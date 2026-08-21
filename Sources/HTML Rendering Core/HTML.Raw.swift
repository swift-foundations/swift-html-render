import ASCII
public import Render_Primitives
public import WHATWG_HTML_Shared

extension HTML {

    public struct Raw: HTML.View, Sendable {

        public let bytes: [UInt8]

        public init(_ string: String) {
            self.bytes = Array(string.utf8)
        }

        public init(_ bytes: [UInt8]) {
            self.bytes = bytes
        }
    }
}

extension HTML.Raw {
    public typealias Body = Never
    public var body: Never { fatalError("Body is Never and must not be accessed.") }

    public static func _render(
        _ view: borrowing Self,
        context: inout Render.Context
    ) {
        context.write(raw: view.bytes)
    }
}
