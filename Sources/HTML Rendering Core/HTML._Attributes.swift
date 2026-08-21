public import Dictionary_Ordered_Primitives
import Dictionary_Primitives
public import Render_Primitives
public import WHATWG_HTML_Shared

extension HTML {

    public struct _Attributes<Content: HTML.View>: HTML.View {

        public let content: Render.Indirect<Content>

        public var attributes: HTML.Context.Attributes

        public init(content: Content, attributes: HTML.Context.Attributes) {
            self.content = Render.Indirect(content)
            self.attributes = attributes
        }

        public func attribute(_ name: String, _ value: String? = "") -> HTML._Attributes<Content> {
            var copy = self
            copy.attributes[name] = value
            return copy
        }

        public typealias Body = Never
        public var body: Never { fatalError("Body is Never and must not be accessed.") }

        public static func _render(
            _ view: borrowing Self,
            context: inout Render.Context
        ) {
            context.open(push: .attributes, pop: .attributes)
            view.attributes.forEach { key, value in
                context.set(attribute: key, value)
            }
            Content._render(view.content.value, context: &context)
        }
    }
}

extension HTML._Attributes: Sendable where Content: Sendable {}
