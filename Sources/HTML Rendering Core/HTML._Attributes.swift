//
//  HTML._Attributes.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

import Dictionary_Primitives
public import Dictionary_Ordered_Primitives
public import Render_Primitives
public import WHATWG_HTML_Shared

extension HTML {
    /// A wrapper that applies attributes to an HTML element.
    ///
    /// Attributes are HTML-specific. When rendered through an `HTML.Context`,
    /// attributes are set on the context and picked up by the next element's
    /// opening tag. In foreign contexts, attributes degrade (content renders,
    /// attributes are lost).
    public struct _Attributes<Content: HTML.View>: HTML.View {
        /// The HTML content to which attributes are being applied.
        ///
        /// Stored indirectly (heap-allocated) to keep `_Attributes` at constant
        /// size regardless of content complexity, preventing stack overflow
        /// on the cooperative thread pool (544 KB) in deep modifier chains.
        public let content: Render.Indirect<Content>

        /// The collection of attributes to apply.
        public var attributes: HTML.Context.Attributes

        public init(content: Content, attributes: HTML.Context.Attributes) {
            self.content = Render.Indirect(content)
            self.attributes = attributes
        }

        /// Adds an additional attribute to this element.
        public func attribute(_ name: String, _ value: String? = "") -> HTML._Attributes<Content> {
            var copy = self
            copy.attributes[name] = value
            return copy
        }

        public typealias Body = Never
        public var body: Never { fatalError() }

        /// Renders content, setting attributes on the context when supported.
        /// In foreign contexts, content renders but attributes are lost.
        public static func _render(
            _ view: borrowing Self, context: inout Render.Context
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
