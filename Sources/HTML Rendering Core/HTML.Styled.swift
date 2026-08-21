import Render_Primitives
public import W3C_CSS_Shared
public import WHATWG_HTML_Shared

extension HTML {

    public struct Styled<Content, P: W3C_CSS_Shared.Property> {

        public let content: Render.Indirect<Content>

        public let property: P?

        public let style: HTML.Style.Rule?

        public let atRule: HTML.AtRule?

        public let selector: HTML.Selector?

        public let pseudo: HTML.Pseudo?

        public init(
            _ content: Content,
            _ property: P?,
            atRule: HTML.AtRule? = nil,
            selector: HTML.Selector? = nil,
            pseudo: HTML.Pseudo? = nil
        ) {
            self.content = Render.Indirect(content)
            self.property = property
            self.style = property.map {
                HTML.Style.Rule($0, atRule: atRule, selector: selector, pseudo: pseudo)
            }
            self.atRule = atRule
            self.selector = selector
            self.pseudo = pseudo
        }
    }
}

extension HTML.Styled: Render.View where Content: HTML.View {
    public typealias Body = Never
    public var body: Never { fatalError("Body is Never and must not be accessed.") }

    public static func _render(
        _ view: borrowing Self,
        context: inout Render.Context
    ) {
        context.open(push: .style, pop: .style)
        var handled = false
        if let property = view.property {
            handled = context.apply(inlineStyle: property)
        }
        if !handled, let style = view.style {
            if let className = context.register(
                style: style.declaration,
                atRule: style.atRule?.rawValue,
                selector: style.selector?.rawValue,
                pseudo: style.pseudo?.rawValue
            ) {
                context.add(class: className)
            }
        }
        Content._render(view.content.value, context: &context)
    }
}

extension HTML.Styled: HTML.View where Content: HTML.View {}

extension HTML.Styled: Sendable where Content: Sendable, P: Sendable {}

extension HTML.View {

    public func inlineStyle<P: W3C_CSS_Shared.Property>(
        _ property: P?
    ) -> HTML.Styled<Self, P> {
        let ctx = HTML.Style.Rule.Context.current
        return HTML.Styled(
            self,
            property,
            atRule: ctx.atRule,
            selector: ctx.selector,
            pseudo: ctx.pseudo
        )
    }
}
