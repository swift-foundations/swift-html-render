public import Render_Primitives
public import WHATWG_HTML_Shared

extension HTML {

    public struct AnyView: HTML.View, @unchecked Sendable {
        let renderInto: (inout Render.Context) -> Void

        private init(renderInto: @escaping (inout Render.Context) -> Void) {
            self.renderInto = renderInto
        }

        public init<T: HTML.View>(_ base: T) {
            if let anyView = base as? HTML.AnyView {
                self = anyView
            } else {
                self.renderInto = { context in T._render(base, context: &context) }
            }
        }
    }
}

extension HTML.AnyView {
    public typealias Body = Never
    public var body: Never { fatalError("Body is Never and must not be accessed.") }

    public static func _render(
        _ view: borrowing HTML.AnyView,
        context: inout Render.Context
    ) {
        view.renderInto(&context)
    }
}

extension HTML.AnyView {

    public init<Content: HTML.View>(@HTML.Builder _ closure: () -> Content) {
        self.init(closure())
    }
}
