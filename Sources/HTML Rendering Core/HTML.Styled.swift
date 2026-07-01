//
//  HTML.Styled.swift
//  swift-html-rendering
//
//  Applies CSS styles to HTML content via generated class names.
//

import Render_Primitives
public import W3C_CSS_Shared
public import WHATWG_HTML_Shared

extension HTML {
    /// A wrapper that applies a CSS style to HTML content.
    ///
    /// CSS styling is HTML-specific. When rendered through `HTML.Context`,
    /// the style is registered and a class name is added to the context's attributes.
    /// In foreign contexts, styles degrade (content renders, CSS is lost).
    public struct Styled<Content, P: W3C_CSS_Shared.Property> {
        /// The HTML content being styled.
        ///
        /// Stored indirectly (heap-allocated) to keep `Styled` at constant
        /// size regardless of content complexity, preventing stack overflow
        /// on the cooperative thread pool (544 KB) in deep modifier chains.
        public let content: Render.Indirect<Content>

        /// The typed CSS property (nil if no style).
        public let property: P?

        /// The style metadata for HTML rendering.
        public let style: HTML.Element.Style?

        /// Optional at-rule (e.g., media query).
        public let atRule: HTML.AtRule?

        /// Optional CSS selector prefix.
        public let selector: HTML.Selector?

        /// Optional pseudo-class or pseudo-element.
        public let pseudo: HTML.Pseudo?

        /// Creates a styled HTML element from a typed CSS property.
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
                HTML.Element.Style($0, atRule: atRule, selector: selector, pseudo: pseudo)
            }
            self.atRule = atRule
            self.selector = selector
            self.pseudo = pseudo
        }
    }
}

extension HTML.Styled: Render.View where Content: HTML.View {
    public typealias Body = Never
    public var body: Never { fatalError() }

    /// Renders styled content through the generic context path.
    ///
    /// First attempts `apply(inlineStyle:)` for contexts that handle typed CSS
    /// properties directly (e.g., PDF.HTML.Context). Falls back to
    /// `register(style:...)` for contexts that use CSS class names (e.g., HTML.Context).
    public static func _render(
        _ view: borrowing Self, context: inout Render.Context
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

// MARK: - HTML.View Extension

extension HTML.View {
    /// Applies a typed CSS property to an HTML element.
    public func inlineStyle<P: W3C_CSS_Shared.Property>(
        _ property: P?
    ) -> HTML.Styled<Self, P> {
        let ctx = HTML.Element.Style.Context.current
        return HTML.Styled(
            self,
            property,
            atRule: ctx.atRule,
            selector: ctx.selector,
            pseudo: ctx.pseudo
        )
    }
}
